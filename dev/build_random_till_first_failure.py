import json
import sys
import subprocess
from pathlib import Path
import random

random.seed(0)


def normalize_python_package_name(pkg):
    return pkg.lower().replace("_", "-").replace('.','-')


all_pkgs = json.loads((Path(__file__).parent.parent / "todo" / "todo.json").read_text())
excluded_pkgs = json.loads(
    (Path(__file__).parent.parent / "todo" / "manually_excluded.json").read_text()
)


def write_excluded_pkgs():
    (Path(__file__).parent.parent / "todo" / "manually_excluded.json").write_text(
        json.dumps(excluded_pkgs, indent=2)
    )


done = [
    x.name for x in Path(".").glob("hammer_build*") if (x / "build" / "result").is_symlink()
]
done = set([normalize_python_package_name(x.split("_")[2]) for x in done])
imported_done = set(
    [
        normalize_python_package_name(x.name.split("_")[3])
        for x in Path(".").glob("imported_hammer_build*")
        if (x / "build" / "result").is_symlink()
    ]
)
attempted = [
    x.name
    for x in Path(".").glob("hammer_build*")
    if not (x / "build" / "result").exists() and (x / "build" / "run_0.log").exists()
]
attempted = set([normalize_python_package_name(x.split("_")[2]) for x in attempted])

total = len(all_pkgs)
count = 0

keep_going = "--keep-going" in sys.argv

while True:
    chosen = random.choice(all_pkgs)
    chosen = normalize_python_package_name(chosen)
    count += 1
    if count > total:
        break
    if (Path("overrides") / chosen).exists():
        print("skipping", chosen)
        continue
    if chosen in done:
        print("skipping, done", chosen)
        continue
    if chosen in imported_done:
        print("skipping, done & imported", chosen)
        continue
    if chosen in excluded_pkgs:
        print("skipping, excluded", chosen)
        continue
    if chosen in attempted and keep_going:
        print("skipping, attempted (&keep-going)", chosen)
        continue
    cmd = ["uv2nix-hammer", "--wheel", chosen]
    print("executing", " ".join(cmd), "count", count, "of", total)
    p = subprocess.Popen(cmd, stderr=subprocess.PIPE, stdout=subprocess.PIPE)
    stdout, stderr = p.communicate()
    stderr = stderr.decode()
    if p.returncode != 0:
        if "No non-pre release found" in stderr:
            excluded_pkgs[chosen] = "Automatic: no (non-pre) release found"
            write_excluded_pkgs()
            continue

        if "No releases available" in stderr:
            print("No releases available", chosen)
            excluded_pkgs[chosen] = "Automatic: no releases available"
            write_excluded_pkgs()
            continue
        if "has no wheels with a matching Python ABI" in stderr:
            print("no wheels for this ABI")
            excluded_pkgs[chosen] = (
                "Automatic: no wheels for this ABI (and no source). Possibly we misidentified the supported python version"
            )
            write_excluded_pkgs()
            continue
        if 'NeedsExclusion' in stderr:
            reason = stderr.rsplit('NeedsExclusion: ', 1)[1].strip().split("\n")[0]
            print("needed to be excluded", reason)
            excluded_pkgs[chosen] = f"Automatic: {reason}"
            write_excluded_pkgs()
            continue
        if "Missing parentheses in call to 'print'." in stderr:
            print("Missing parentheses in call to 'print'.")
            excluded_pkgs[chosen] = "Automatic: python2 only, Missing parentheses in call to 'print'."
            write_excluded_pkgs()
            continue
        try:
            run_0 = None
            run_0 = (
                list(Path(".").glob(f"hammer_build_{chosen}_*"))[0] / "build/run_0.log"
            )
        except IndexError:
            print("no run performed?", chosen)
            excluded_pkgs[chosen] = "Automatic: no run performed, uv failure?"
            write_excluded_pkgs()
        if run_0 is not None and run_0.exists():
            r0 = run_0.read_text()
            if "error: infinite recursion encountered" in r0:
                print("infinite recursion encountered", chosen)
                excluded_pkgs[chosen] = "Automatic: infinite recursion encountered"
                write_excluded_pkgs()
                continue
        # elif "we can conclude that your project's requirements are unsatisfiable.":
        #     excluded_pkgs[chosen] = (
        #         "Automatic: unsatisfiable requirements - python version?"
        #     )
        # else:
        print("return code was not 0")
        sys.stdout.write(stdout.decode("utf-8"))
        sys.stdout.write(stderr)
        if not keep_going:
            sys.exit(1)
    print("done", cmd)

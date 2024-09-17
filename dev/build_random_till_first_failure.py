import json
import toml
import sys
import subprocess
from pathlib import Path
import random

random.seed(0)


def normalize_python_package_name(pkg):
    return pkg.lower().replace("_", "-").replace(".", "-")


all_pkgs = json.loads((Path(__file__).parent.parent / "todo" / "todo.json").read_text())
excluded_pkgs = toml.loads(
    (Path(__file__).parent.parent / "todo" / "excluded.toml").read_text()
)


def write_excluded_pkgs():
    (Path(__file__).parent.parent / "todo" / "excluded.toml").write_text(
        toml.dumps(excluded_pkgs)
    )


done = [
    x.name
    for x in Path(".").glob("hammer_build*")
    if (x / "build" / "result").is_symlink()
]
done = set([normalize_python_package_name(x.split("_")[2]) for x in done])
imported_done = set(
    [
        normalize_python_package_name(x.name.split("_")[3])
        for x in Path(".").glob("imported_hammer_build*")
        if (x / "build" / "result").exists() or (x / "build" / "result").is_symlink()
    ]
)
attempted = [
    x.name
    for x in Path(".").glob("hammer_build*")
    if not (x / "build" / "result").exists() and (x / "build" / "run_0.log").exists()
]
attempted = set([normalize_python_package_name(x.split("_")[2]) for x in attempted])

order = sorted(all_pkgs)
random.shuffle(order)

keep_going = "--keep-going" in sys.argv
todo = set([normalize_python_package_name(x) for x in all_pkgs])
todo = todo.difference(done)
todo = todo.difference(imported_done)
todo = todo.difference(set(excluded_pkgs.keys()))
if keep_going:
    todo = todo.difference(attempted)

total = len(all_pkgs)
accounted = len(all_pkgs) - len(todo)
print("accounted", accounted, "out of", total)


count = 0
for chosen in order:
    if chosen not in todo or normalize_python_package_name(chosen) not in todo:
        continue
    chosen = normalize_python_package_name(chosen)
    count += 1
    print(count, "/", len(todo))
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
    if chosen in attempted and "--break" in sys.argv:
        print("Aborting because of prev. attempt", chosen)
        sys.exit()
    cmd = ["uv2nix-hammer", "--wheel", chosen]
    print("executing", " ".join(cmd))
    p = subprocess.Popen(
        cmd,
        stderr=subprocess.PIPE,
        stdout=subprocess.PIPE,
    )
    try:
        stdout, stderr = p.communicate(timeout=600)
        stderr = stderr.decode()
    except:
        stderr = "timout"
        p = subprocess.run(["false"])
    msg = None
    if p.returncode != 0:
        if 'timeout' in stderr:
            msg = "timeout"
        if "No non-pre release found" in stderr:
            msg == "Automatic: no (non-pre) release found"

        if "No releases available" in stderr:
            msg = "Automatic: no releases available"
        if "has no wheels with a matching Python ABI" in stderr:
            msg = "Automatic: no wheels for this ABI (and no source). Possibly we misidentified the supported python version"
        if "NeedsExclusion: " in stderr:
            reason = stderr.rsplit("NeedsExclusion: ", 1)[1].strip().split("\n")[0]
            msg = f"Automatic: {reason}"
        if "Missing parentheses in call to 'print'." in stderr:
            msg = "Automatic: python2 only, Missing parentheses in call to 'print'."
        if "except ParseBaseException, err:" in stderr:
            msg = "Automatic: python2 only, except statement"
        if "assertion '(compatibleWheels != [ ])' failed" in stderr:
            msg = "Automatic: no compatible wheels (and no source)"
        if (
            "ModuleNotFoundError: No module named 'imp'" in stderr
            and "'['uv', 'lock'," in stderr
        ):
            msg = "Automatic: uv failure, required imp."
        if 'ValueError: No non-pre release found' in stderr:
            msg = "Automatic: no non-pre release found"
        if "package not on pypi" in stderr:
            msg = "Automatic: package not on pypi"
        if "was not found in the package registry" in stderr:
            msg = "Automatic: uv failure: Dependency not found in package registry"
        if "No solution found when resolving dependencies" in stderr:
            msg = "Automic: uv lock failure, no solution when resolving dependencies"
        if "use_2to3 is invalid." in stderr:
            msg = "uv lock error, 'use_2to3 is invalid.'"
        if " Command '['uv', 'lock', '--no-cache', " in stderr:
            msg = "uv lock failure, Unspecifieded"

        if msg:
            print(msg)
            excluded_pkgs[chosen] = msg
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

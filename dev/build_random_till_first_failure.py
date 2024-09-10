import json
import sys
import subprocess
from pathlib import Path
import random

random.seed(0)


all_pkgs = json.loads((Path(__file__).parent.parent / "todo" / "todo.json").read_text())
excluded_pkgs = json.loads(
    (Path(__file__).parent.parent / "todo" / "manually_excluded.json").read_text()
)


def write_excluded_pkgs():
    (Path(__file__).parent.parent / "todo" / "manually_excluded.json").write_text(
        json.dumps(excluded_pkgs, indent=2)
    )


done = [
    x.name for x in Path(".").glob("hammer_build*") if (x / "build" / "result").exists()
]
done = set([x.split("_")[2] for x in done])
imported_done = set([
    x.name.split("_")[3]
    for x in Path(".").glob("imported_hammer_build*")
    if (x / "build" / "result").exists()
])


while True:
    chosen = random.choice(all_pkgs)
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
    cmd = ["uv2nix-hammer", "--wheel", chosen]
    print(" ".join(cmd))
    p = subprocess.Popen(cmd, stderr=subprocess.PIPE, stdout=subprocess.PIPE)
    stdout, stderr = p.communicate()
    stderr = stderr.decode()
    if p.returncode != 0:
        if "No non-pre release found" in stderr:
            excluded_pkgs[chosen] = "Automatic: no (non-pre) release found"
            write_excluded_pkgs()
            continue
        run_0 = list(Path('.').glob(f'hammer_build_{chosen}_*'))[0] / "build/run_0.log"
        if run_0.exists():
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
        sys.stdout.write(stdout.decode('utf-8'))
        sys.stdout.write(stderr)
        if not '--keep-going' in sys.argv:
            sys.exit(1)

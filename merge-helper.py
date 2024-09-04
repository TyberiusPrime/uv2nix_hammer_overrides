import subprocess
import shutil
from pathlib import Path


available = [x for x in Path("../uv2nix_hammer/").glob("hammer_build*") if x.is_dir()]
if not available:
    print("No hammer_build* directories found")
    exit(1)
if len(available) > 1:
    for ii, x in enumerate(
        available,
    ):
        print(f"{ii}: {x}")
    choice = input("Which one to use? ")
    choice = int(choice)
    chosen = available[choice]
else:
    chosen = available[0]
print("pulling from", chosen)

subprocess.run(["git", "pull", chosen / "overrides", "--no-rebase"])
subprocess.run(["./dev/collect.py"])
subprocess.run(["git", "add", "collected.nix"])
subprocess.check_call(["git", "merge", "--continue"])
shutil.move(chosen, chosen.with_name("imported_" + chosen.name))

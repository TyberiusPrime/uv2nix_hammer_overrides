import subprocess
import shutil
from pathlib import Path

found = list(Path("../builds/").glob("hammer_build*"))
available = [x for x in found if x.is_dir() and (x / 'build' / 'result').exists()]
if not available:
    print("No hammer_build* directories found")
    print("Found without build result:")
    print(found)
    exit(1)

# if len(available) > 1:
#     for ii, x in enumerate(
#         available,
#     ):
#         print(f"{ii}: {x}")
#     choice = input("Which one to use? ")
#     choice = int(choice)
#     chosen = available[choice]
# else:
#     chosen = available[0]
# print("pulling from", chosen)

for chosen in available:
    print(chosen)
    subprocess.run(["git", "pull", chosen / "overrides", "--no-rebase"])
    output = subprocess.check_output(['git', 'status', '--porcelain'])
    if b'UU' in output:
        print('Conflict exists')
        subprocess.run(["./dev/collect.py"])
        subprocess.run(["git", "add", "collected.nix"])
        subprocess.check_call(["git", "merge", "--continue"])
    shutil.move(chosen, chosen.with_name("imported_" + chosen.name))

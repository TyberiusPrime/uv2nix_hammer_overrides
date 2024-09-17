import subprocess
import os
import shutil
from pathlib import Path

found = list(Path("../builds/").glob("hammer_build*"))
# we have to check the symlink,
# since we're currently building in a container with a separate nix store.
available = [x for x in found if x.is_dir() and (x / 'build' / 'result').is_symlink()]
if not available:
    print("No hammer_build* directories found")
    print("Found without build result:")
    for f in found:
        print("\t", f)
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

commited_any = False

for chosen in available:
    print(chosen)
    env = os.environ.copy()
    env['EDITOR'] = 'true'
    subprocess.check_call(["git", "pull", chosen / "overrides", "--no-rebase"], env=env)
    output = subprocess.check_output(['git', 'status', '--porcelain'], env=env)
    if b'UU' in output:
        print('Conflict exists')
        subprocess.run(["./dev/collect.py"])
        subprocess.run(["git", "add", "collected.nix"], env=env)
        subprocess.check_call(["git", "merge", "--continue"],
                              env = env)
    shutil.move(chosen, chosen.with_name("imported_" + chosen.name))
    commited_any = True


if commited_any:
    subprocess.check_call(['nix-collect-garbage'])

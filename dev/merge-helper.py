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

last_failed = False
for chosen in available:
    print(chosen)
    env = os.environ.copy()
    env['EDITOR'] = 'true'
    p = subprocess.run(["git", "pull", chosen / "overrides", "--no-rebase"], env=env)
    pull_failed  = p.returncode != 0
    output = subprocess.check_output(['git', 'status', '--porcelain'], env=env)
    if b'UU' in output or b'AA' in output:
        print('Conflict exists')
        subprocess.check_call(["./dev/collect.py"])
        subprocess.check_call(["git", "add", "collected.nix"], env=env)
        subprocess.check_call(["git", "add", "overrides"], env=env)
        subprocess.check_call(["git", "merge", "--continue"],
                              env = env)
        print("both added")
    elif pull_failed:
        raise ValueError("pull failed")
    shutil.move(chosen, chosen.with_name("imported_" + chosen.name))
    commited_any = True


if commited_any:
    subprocess.check_call(['nix-collect-garbage'])

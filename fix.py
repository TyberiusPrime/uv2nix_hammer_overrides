import shutil
import subprocess

from pathlib import Path

todo = Path("t.txt").read_text().strip().split("\n")


for entry in todo:
    pkg, ver = entry.split("_")[2:4]
    source = (
        Path("../builds/imported")
        / f"imported_hammer_build_{pkg}_{ver}"
        / "overrides"
    )
    for fn in source.glob("**/*"):
        if fn.name == 'fix.sh':
            continue
        if fn.is_file():
            target = Path('overrides') / fn.absolute().relative_to(source.absolute())
            print(fn, '->',target)
            target.parent.mkdir(exist_ok=True, parents=True)
            with open(target,'wb') as of:
                with open(fn,'rb') as inf:
                    of.write(inf.read())

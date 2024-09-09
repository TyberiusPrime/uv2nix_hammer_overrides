from pathlib import Path
import json
all_pkgs = set()
for fn in Path("input").glob("*.json"):
    print(fn)
    j = json.loads(fn.read_text())
    all_pkgs.update(j)

# there are some in nixpkgs that ain't on pypi
all_pypi = set(json.loads(Path('all_pypi_packages.json').read_text()))
all_pkgs = all_pkgs.intersection(all_pypi)

Path('todo.json').write_text(json.dumps(sorted(all_pkgs), indent=2))
print(len(all_pkgs))

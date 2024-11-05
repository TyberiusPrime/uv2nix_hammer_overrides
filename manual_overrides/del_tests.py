import sys
from pathlib import Path

arg = sys.argv[1]
pkg, ver = arg.rsplit("-", 1)
path = sys.argv[2] if len(sys.argv) > 2 else 'tests'
of = Path(pkg) / ver / "default.nix"
of.parent.mkdir(exist_ok=True, parents=True)
if not of.exists():
    of.write_text("""{
  postInstall =
    old.postInstall
    or ""
    + ''
      rm -rf $out/${final.python.sitePackages}/""" + path + """
    '';
}
""")
else:
    raise ValueError("File already exists")

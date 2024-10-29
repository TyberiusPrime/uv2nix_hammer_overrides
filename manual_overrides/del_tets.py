import sys
from pathlib import Path

arg = sys.argv[1]
pkg, ver = arg.rsplit("-", 1)
of = Path(pkg) / ver / "default.nix"
of.parent.mkdir(exist_ok=True, parents=True)
if not of.exists():
    of.write_text("""{
  postInstall =
    old.postInstall
    or ""
    + ''
      rm -rf $out/${final.python.sitePackages}/tests
    '';
}
""")
else:
    raise ValueError("File already exists")

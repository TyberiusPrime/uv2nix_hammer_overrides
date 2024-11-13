{ resolveBuildSystem, helpers, ... }:
old:
if (helpers.isWheel old) then
  { }
else
  {
    nativeBuildInputs = old.nativeBuildInputs or [ ] ++ (resolveBuildSystem { setuptools = [ ]; });
    preBuild = [
      old.preBuild or ""
      ''
        cd /build
        # find the first directory containing either pyproject.toml or setup.py
        buildDir=$(find . -maxdepth 1 -type d -exec test -e "{}/pyproject.toml" -o -e "{}/setup.py" \; -print -quit)
        cd $buildDir
      ''
    ];
  }

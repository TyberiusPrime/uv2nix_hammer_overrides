{ resolveBuildSystem, pkgs, ... }:
old:
if ((old.passthru.format or "sdist") == "wheel") then
  { }
else
  {
    nativeBuildInputs = old.nativeBuildInputs or [ ] ++ (resolveBuildSystem { setuptools = [ ]; });
    preConfigure = [
      old.preConfigure or ""
      pkgs.python3Packages.pillow.preConfigure
    ];
  }
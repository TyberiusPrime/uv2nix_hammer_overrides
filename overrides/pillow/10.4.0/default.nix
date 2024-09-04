{ final, pkgs, ... }:
old:
if ((old.format or "sdist") == "wheel") then
  { }
else
  {
    nativeBuildInputs = old.nativeBuildInputs or [ ] ++ [ final.setuptools ];
    inherit (pkgs.python3Packages.pillow) preConfigure;
  }

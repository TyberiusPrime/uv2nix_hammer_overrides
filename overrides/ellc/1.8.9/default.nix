{ final, pkgs, ... }:
old:
if ((old.format or "sdist") == "wheel") then
  { }
else
  { nativeBuildInputs = old.nativeBuildInputs or [ ] ++ [ pkgs.gfortran ] ++ [ final.setuptools ]; }

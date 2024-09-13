{ final, pkgs, ... }:
old:
if ((old.format or "sdist") == "wheel") then
  { }
else
  { nativeBuildInputs = old.nativeBuildInputs or [ ] ++ [ pkgs.krb5Full ] ++ [ final.setuptools ]; }

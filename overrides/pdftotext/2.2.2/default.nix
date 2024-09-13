{ final, pkgs, ... }:
old:
if ((old.format or "sdist") == "wheel") then
  { buildInputs = old.buildInputs or [ ] ++ [ pkgs.poppler ]; }
else
  {
    buildInputs = old.buildInputs or [ ] ++ [ pkgs.poppler ];
    nativeBuildInputs = old.nativeBuildInputs or [ ] ++ [ final.setuptools ];
  }

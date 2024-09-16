{ final, pkgs, ... }:
old:
if ((old.format or "sdist") == "wheel") then
  { buildInputs = old.buildInputs or [ ] ++ [ pkgs.xz.dev ]; }
else
  {
    buildInputs = old.buildInputs or [ ] ++ [ pkgs.xz.dev ];
    nativeBuildInputs = old.nativeBuildInputs or [ ] ++ [ final.setuptools ];
  }

{ final, pkgs, ... }:
old:
if ((old.format or "sdist") == "wheel") then
  { buildInputs = old.buildInputs or [ ] ++ [ pkgs.chmlib ]; }
else
  {
    buildInputs = old.buildInputs or [ ] ++ [ pkgs.chmlib ];
    nativeBuildInputs = old.nativeBuildInputs or [ ] ++ [ final.setuptools ];
  }

{ final, pkgs, ... }:
old:
if ((old.format or "sdist") == "wheel") then
  { buildInputs = old.buildInputs or [ ] ++ [ pkgs.gmp ]; }
else
  {
    buildInputs = old.buildInputs or [ ] ++ [ pkgs.gmp ];
    nativeBuildInputs =
      old.nativeBuildInputs or [ ]
      ++ [
        pkgs.gmp.dev
        pkgs.pkg-config
      ]
      ++ [ final.setuptools ];
  }

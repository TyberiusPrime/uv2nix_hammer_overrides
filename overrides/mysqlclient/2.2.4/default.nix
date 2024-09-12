{ final, pkgs, ... }:
old:
if ((old.format or "sdist") == "wheel") then
  { buildInputs = old.buildInputs or [ ] ++ [ pkgs.libmysqlclient ]; }
else
  {
    buildInputs = old.buildInputs or [ ] ++ [ pkgs.libmysqlclient ];
    nativeBuildInputs =
      old.nativeBuildInputs or [ ]
      ++ [
        pkgs.libmysqlclient
        pkgs.pkg-config
      ]
      ++ [ final.setuptools ];
  }

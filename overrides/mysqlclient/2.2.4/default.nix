{ resolveBuildSystem, pkgs, ... }:
old:
if ((old.passthru.format or "sdist") == "wheel") then
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
      ++ (resolveBuildSystem { setuptools = [ ]; });
  }
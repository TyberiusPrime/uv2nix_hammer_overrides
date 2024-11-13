{ resolveBuildSystem, pkgs, ... }:
old:
if ((old.passthru.format or "sdist") == "wheel") then
  { buildInputs = old.buildInputs or [ ] ++ [ pkgs.glib ]; }
else
  {
    buildInputs = old.buildInputs or [ ] ++ [ pkgs.glib ];
    nativeBuildInputs =
      old.nativeBuildInputs or [ ]
      ++ [
        pkgs.glib.dev
        pkgs.pkg-config
      ]
      ++ (resolveBuildSystem { setuptools = [ ]; });
  }

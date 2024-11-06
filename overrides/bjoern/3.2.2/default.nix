{ resolveBuildSystem, pkgs, ... }:
old:
if ((old.passthru.format or "sdist") == "wheel") then
  { buildInputs = old.buildInputs or [ ] ++ [ pkgs.libev ]; }
else
  {
    buildInputs = old.buildInputs or [ ] ++ [ pkgs.libev ];
    nativeBuildInputs = old.nativeBuildInputs or [ ] ++ (resolveBuildSystem { setuptools = [ ]; });
  }
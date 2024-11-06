{ resolveBuildSystem, pkgs, ... }:
old:
if ((old.passthru.format or "sdist") == "wheel") then
  { buildInputs = old.buildInputs or [ ] ++ [ pkgs.xz.dev ]; }
else
  {
    buildInputs = old.buildInputs or [ ] ++ [ pkgs.xz.dev ];
    nativeBuildInputs = old.nativeBuildInputs or [ ] ++ (resolveBuildSystem { setuptools = [ ]; });
  }
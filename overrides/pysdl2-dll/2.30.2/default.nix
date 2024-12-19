{
  helpers,
  pkgs,
  resolveBuildSystem,
  ...
}:
old:
if (helpers.isWheel old) then
  { buildInputs = old.buildInputs or [ ] ++ [ pkgs.SDL2 ]; }
else
  {
    buildInputs = old.buildInputs or [ ] ++ [ pkgs.SDL2 ];
    nativeBuildInputs = old.nativeBuildInputs or [ ] ++ (resolveBuildSystem { setuptools = [ ]; });
  }

{
  helpers,
  pkgs,
  resolveBuildSystem,
  ...
}:
old:
if (helpers.isWheel old) then
  { buildInputs = old.buildInputs or [ ] ++ [ pkgs.ncurses ]; }
else
  {
    buildInputs = old.buildInputs or [ ] ++ [ pkgs.ncurses ];
    nativeBuildInputs = old.nativeBuildInputs or [ ] ++ (resolveBuildSystem { setuptools = [ ]; });
  }

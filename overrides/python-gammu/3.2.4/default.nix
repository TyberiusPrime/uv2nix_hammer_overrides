{
  helpers,
  pkgs,
  resolveBuildSystem,
  ...
}:
old:
if (helpers.isWheel old) then
  { buildInputs = old.buildInputs or [ ] ++ [ pkgs.gammu ]; }
else
  {
    buildInputs = old.buildInputs or [ ] ++ [ pkgs.gammu ];
    nativeBuildInputs =
      old.nativeBuildInputs or [ ] ++ [ pkgs.pkg-config ] ++ (resolveBuildSystem { setuptools = [ ]; });
  }

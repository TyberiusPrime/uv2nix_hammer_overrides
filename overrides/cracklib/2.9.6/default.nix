{
  resolveBuildSystem,
  helpers,
  pkgs,
  ...
}:
old:
if (helpers.isWheel old) then
  { buildInputs = old.buildInputs or [ ] ++ [ pkgs.cracklib ]; }
else
  {
    buildInputs = old.buildInputs or [ ] ++ [ pkgs.cracklib ];
    nativeBuildInputs = old.nativeBuildInputs or [ ] ++ (resolveBuildSystem { setuptools = [ ]; });
  }

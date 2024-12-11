{
  helpers,
  pkgs,
  resolveBuildSystem,
  ...
}:
old:
if (helpers.isWheel old) then
  {
    buildInputs = old.buildInputs or [ ] ++ [
      pkgs.bluez
      pkgs.boost
    ];
  }
else
  {
    buildInputs = old.buildInputs or [ ] ++ [
      pkgs.bluez
      pkgs.boost
    ];
    nativeBuildInputs = old.nativeBuildInputs or [ ] ++ (resolveBuildSystem { setuptools = [ ]; });
  }

{
  helpers,
  pkgs,
  resolveBuildSystem,
  ...
}:
old:
if (helpers.isWheel old) then
  { buildInputs = old.buildInputs or [ ] ++ [ pkgs.libusb1 ]; }
else
  {
    buildInputs = old.buildInputs or [ ] ++ [ pkgs.libusb1 ];
    nativeBuildInputs = old.nativeBuildInputs or [ ] ++ (resolveBuildSystem { hatchling = [ ]; });
  }

{
  helpers,
  pkgs,
  resolveBuildSystem,
  ...
}:
old:
if (helpers.isWheel old) then
  { buildInputs = old.buildInputs or [ ] ++ [ pkgs.udev ]; }
else
  {
    buildInputs = old.buildInputs or [ ] ++ [ pkgs.udev ];
    nativeBuildInputs =
      old.nativeBuildInputs or [ ]
      ++ (resolveBuildSystem {
        setuptools = [ ];
        wheel = [ ];
      });
  }

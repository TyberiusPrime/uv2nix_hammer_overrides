{
  helpers,
  pkgs,
  resolveBuildSystem,
  ...
}:
old:
if (helpers.isWheel old) then
  { }
else
  {
    nativeBuildInputs =
      old.nativeBuildInputs or [ ]
      ++ [ pkgs.meson ]
      ++ (resolveBuildSystem {
        meson = [ ];
        meson-python = [ ];
        ninja = [ ];
        pybind11 = [ ];
      });
  }

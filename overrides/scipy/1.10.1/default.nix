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
      pkgs.openblas
      pkgs.pkg-config
      pkgs.suitesparse
    ];
  }
else
  {
    buildInputs = old.buildInputs or [ ] ++ [
      pkgs.openblas
      pkgs.pkg-config
      pkgs.suitesparse
    ];
    dontUseCmakeConfigure = true;
    nativeBuildInputs =
      old.nativeBuildInputs or [ ]
      ++ [
        pkgs.cmake
        pkgs.gfortran
        pkgs.meson
        pkgs.pkg-config
      ]
      ++ (resolveBuildSystem {
        "cython_0" = [ ];
        meson-python = [ ];
        ninja = [ ];
        numpy = [ ];
        pybind11 = [ ];
        pythran = [ ];
        wheel = [ ];
      });
  }

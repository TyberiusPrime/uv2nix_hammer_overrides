{
  helpers,
  pkgs,
  resolveBuildSystem,
  ...
}:
old:
let
  funcs = [
    (
      old:
      old
      // (
        if (helpers.isWheel old) then
          { }
        else
          {
            nativeBuildInputs =
              old.nativeBuildInputs or [ ]
              ++ (resolveBuildSystem {
                pybind11 = [ ];
                setuptools = [ ];
                wheel = [ ];
              });
          }
      )
    )
    (
      old:
      old
      // (
        if (!helpers.isWheel old) then
          {
            postConfigure = ''
              substituteInPlace setup.py \
                --replace-fail "/usr/include/eigen3/" "${pkgs.eigen}/include/eigen3/"
            '';
          }
        else
          { }
      )
    )
  ];
in
pkgs.lib.trivial.pipe old funcs

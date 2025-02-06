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
                cffi = [ ];
                packaging = [ ];
                setuptools = [ ];
                wheel = [ ];
              });
          }
      )
    )
  ];
in
pkgs.lib.trivial.pipe old funcs

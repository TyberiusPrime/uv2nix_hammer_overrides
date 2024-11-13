{ resolveBuildSystem, pkgs, ... }:
old:
let
  funcs = [
    (
      old:
      old
      // (
        if ((old.passthru.format or "sdist") == "wheel") then
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
    (old: old // { RPY2_CFFI_MODE = "ABI"; })
  ];
in
pkgs.lib.trivial.pipe old funcs

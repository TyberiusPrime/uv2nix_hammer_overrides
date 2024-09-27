{
  resolveBuildSystem,
  helpers,
  pkgs,
  ...
}:
old:
let
  funcs = [
    (
      old:
      old
      // (
        if ((old.format or "sdist") == "wheel") then
          { }
        else
          {
            nativeBuildInputs =
              old.nativeBuildInputs or [ ]
              ++ (resolveBuildSystem {
                setuptools = [ ];
                setuptools-rust = [ ];
                wheel = [ ];
              });
          }
      )
    )
    (
      old:
      old // (pkgs.lib.optionalAttrs (old.format or "sdist" != "wheel") (helpers.standardMaturin { } old))
    )
  ];
in
pkgs.lib.trivial.pipe old funcs

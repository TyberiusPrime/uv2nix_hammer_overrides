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
        if ((old.passthru.format or "sdist") == "wheel") then
          { }
        else
          {
            nativeBuildInputs =
              old.nativeBuildInputs or [ ]
              ++ (resolveBuildSystem {
                cython = [ ];
                setuptools = [ ];
                setuptools-gettext = [ ];
                setuptools-rust = [ ];
              });
          }
      )
    )
    (
      old:
      old // (pkgs.lib.optionalAttrs (old.passthru.format or "sdist" != "wheel") (helpers.standardMaturin { } old))
    )
  ];
in
pkgs.lib.trivial.pipe old funcs
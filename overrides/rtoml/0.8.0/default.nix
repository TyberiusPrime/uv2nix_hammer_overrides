{
  helpers,
  final,
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
            nativeBuildInputs = old.nativeBuildInputs or [ ] ++ [
              final.setuptools-rust
              final.setuptools
              final.wheel
            ];
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

{ helpers, pkgs, ... }:
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
            postPatch =
              (old.postPatch or "")
              + ''
                ${helpers.tomlremove} Cargo.toml package.metadata.maturin
              '';
          }
      )
    )
    (old: old // (pkgs.lib.optionalAttrs (!helpers.isWheel old) (helpers.standardMaturin { } old)))
  ];
in
pkgs.lib.trivial.pipe old funcs

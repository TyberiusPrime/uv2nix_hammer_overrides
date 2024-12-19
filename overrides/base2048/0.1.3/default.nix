{ helpers, pkgs, ... }:
old:
pkgs.lib.optionalAttrs (!helpers.isWheel old) (
  helpers.standardMaturin {
    furtherArgs = {
      postPatch = ''
        cp ${./Cargo.lock} Cargo.lock
      '';
    };
  } old
)

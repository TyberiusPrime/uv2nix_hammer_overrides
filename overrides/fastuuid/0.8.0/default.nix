{pkgs, helpers, ...}
        :
            old:
            let funcs = [(old: old // ( if ((old.format or "sdist") == "wheel") then {} else {postPatch = (old.postPatch or "")+(''
                ${helpers.tomlremove} Cargo.toml package.metadata.maturin
        '');})) (old: old // ( 
              pkgs.lib.optionalAttrs (old.format or "sdist" != "wheel") (
              helpers.standardMaturin {
              furtherArgs = {
                  postPatch = old.postPatch or "" + ''
                  cp ${./Cargo.lock} Cargo.lock
                  '';
              };
              } old)
                                  ))];
            in
            pkgs.lib.trivial.pipe old funcs
    
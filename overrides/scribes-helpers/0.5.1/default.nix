{final, helpers, pkgs, resolveBuildSystem, ...}
        :
            old:
            let funcs = [(old: old // ( if (helpers.isWheel old) then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {setuptools = [];});})) (old: old // ( { preBuild = "export HOME=$(mktemp -d)"; }
))];
            in
            pkgs.lib.trivial.pipe old funcs
    
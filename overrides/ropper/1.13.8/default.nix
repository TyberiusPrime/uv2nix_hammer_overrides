{pkgs, final, resolveBuildSystem, ...}
        :
            old:
            let funcs = [(old: old // ( if ((old.format or "sdist") == "wheel") then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {setuptools = [];});})) (old: old // ( { propagatedBuildInputs = [ final.capstone ]; }
))];
            in
            pkgs.lib.trivial.pipe old funcs
    
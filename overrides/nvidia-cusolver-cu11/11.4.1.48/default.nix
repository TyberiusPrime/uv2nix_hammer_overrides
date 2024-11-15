{helpers, pkgs, ...}
        :
            old:
            let funcs = [(old: old // ( if (helpers.isWheel old) then {buildInputs = old.buildInputs or [] ++ [pkgs.cudaPackages_11.libcublas];} else {buildInputs = old.buildInputs or [] ++ [pkgs.cudaPackages_11.libcublas];env = {dontUsePyprojectBytecode = true;};})) (old: old // ( { dontUsePyprojectBytecode = true; }
))];
            in
            pkgs.lib.trivial.pipe old funcs
    
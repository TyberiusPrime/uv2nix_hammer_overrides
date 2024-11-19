{helpers, pkgs, ...}
        :
            old:
            let funcs = [(old: old // ( {buildInputs = old.buildInputs or [] ++ [pkgs.cudaPackages.libcublas pkgs.cudaPackages.libcusparse pkgs.cudaPackages.libnvjitlink];})) (old: old // ( { dontUsePyprojectBytecode = true; }
))];
            in
            pkgs.lib.trivial.pipe old funcs
    
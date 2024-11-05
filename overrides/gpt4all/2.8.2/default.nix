{pkgs, ...}
        : old: {buildInputs = old.buildInputs or [] ++ [pkgs.cudaPackages_11.cuda_cudart pkgs.cudaPackages_11.libcublas];}
        
{helpers, pkgs, ...}
        : old: {buildInputs = old.buildInputs or [] ++ [pkgs.cudaPackages.cuda_cudart pkgs.cudaPackages.libcublas pkgs.cudaPackages.libcusparse pkgs.cudaPackages_11.cuda_cudart pkgs.cudaPackages_11.libcublas pkgs.cudaPackages_11.libcusparse];}
        
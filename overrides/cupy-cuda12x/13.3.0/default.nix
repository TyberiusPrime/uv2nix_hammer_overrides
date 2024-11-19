{ pkgs, ... }:
old: {
  buildInputs = old.buildInputs or [ ] ++ [
    pkgs.cudaPackages.cuda_nvrtc
    pkgs.cudaPackages.cudnn.lib
    pkgs.cudaPackages.cudnn.out
    pkgs.cudaPackages.cutensor.lib
    pkgs.cudaPackages.cutensor.out
    pkgs.cudaPackages.libcublas
    pkgs.cudaPackages.libcufft
    pkgs.cudaPackages.libcurand
    pkgs.cudaPackages.libcusolver
    pkgs.cudaPackages.libcusparse
    pkgs.cudaPackages.nccl
    pkgs.cudaPackages_10.cudnn.lib
    pkgs.cudaPackages_11.cudnn.lib
  ];
}

{ pkgs, ... }:
old: {
  buildInputs =
    old.buildInputs or [ ]
    ++ (pkgs.lib.optionals (
      (builtins.trace pkgs.stdenv.hostPlatform.system pkgs.stdenv.hostPlatform.system) == "x86_64-linux"
    ) [ pkgs.cudaPackages.cuda_cudart ])
    ++ [
      pkgs.cudaPackages.cuda_cupti
      pkgs.cudaPackages.cuda_nvrtc
      pkgs.cudaPackages.cuda_nvtx
      pkgs.cudaPackages.cudnn
      pkgs.cudaPackages.libcublas
      pkgs.cudaPackages.libcufft
      pkgs.cudaPackages.libcurand
      pkgs.cudaPackages.libcusolver
      pkgs.cudaPackages.libcusparse
      pkgs.cudaPackages.nccl
    ];
}

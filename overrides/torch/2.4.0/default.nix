{ pkgs, ... }:
old: {
  buildInputs = old.buildInputs or [ ] ++ (pkgs.lib.optionals (pkgs.stdenv.hostPlatform.system == "x86_64-linux") [
    pkgs.cudaPackages.cuda_cudart
    pkgs.cudaPackages.cuda_cupti
    pkgs.cudaPackages.cuda_nvrtc
    pkgs.cudaPackages.cuda_nvtx
    pkgs.cudaPackages.cudnn
    pkgs.cudaPackages.libcublas
    pkgs.cudaPackages.libcufft
    pkgs.cudaPackages.libcurand
    pkgs.cudaPackages.libcusparse
    pkgs.cudaPackages.nccl
    pkgs.cudaPackages.libcusolver
  ]);
}

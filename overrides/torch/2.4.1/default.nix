{ pkgs, ... }:
old:
if ((old.format or "sdist") == "wheel") then
  {
    buildInputs = old.buildInputs or [ ] ++ [
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
      pkgs.cudaPackages_11.libcusolver
    ];
  }
else
  {
    buildInputs = old.buildInputs or [ ] ++ [
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
      pkgs.cudaPackages_11.libcusolver
    ];
    env = { };
  }

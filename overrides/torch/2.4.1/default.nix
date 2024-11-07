{final, pkgs, ...}
        :
            old:
            let funcs = [(old: old // ( {buildInputs = old.buildInputs or [] ++ [] ++ (pkgs.lib.optionals ((builtins.trace pkgs.stdenv.hostPlatform.system pkgs.stdenv.hostPlatform.system) == "x86_64-linux") [ pkgs.cudaPackages.cuda_cudart ]) ++ [ pkgs.cudaPackages.cuda_cupti pkgs.cudaPackages.cuda_nvrtc pkgs.cudaPackages.cuda_nvtx pkgs.cudaPackages.cudnn pkgs.cudaPackages.libcublas pkgs.cudaPackages.libcufft pkgs.cudaPackages.libcurand pkgs.cudaPackages.libcusolver pkgs.cudaPackages.libcusparse pkgs.cudaPackages.nccl];})) (old: old // ( {
  postFixup = ''
    rm -rf $out/${final.python.sitePackages}/nvidia/{__pycache__,__init__.py}
    ln -sfn $out/${final.python.sitePackages}/nvidia/*/lib/lib*.so* $out/lib
  '';
}
))];
            in
            pkgs.lib.trivial.pipe old funcs
    
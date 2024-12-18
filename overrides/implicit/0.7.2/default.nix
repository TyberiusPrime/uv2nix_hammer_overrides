{
  helpers,
  pkgs,
  resolveBuildSystem,
  ...
}:
old:
if (helpers.isWheel old) then
  {
    buildInputs = old.buildInputs or [ ] ++ [
      pkgs.cudaPackages.libcurand
      pkgs.cudaPackages_11.cuda_cudart
      pkgs.cudaPackages_11.libcublas
    ];
  }
else
  {
    buildInputs = old.buildInputs or [ ] ++ [
      pkgs.cudaPackages.libcurand
      pkgs.cudaPackages_11.cuda_cudart
      pkgs.cudaPackages_11.libcublas
    ];
    nativeBuildInputs =
      old.nativeBuildInputs or [ ]
      ++ (resolveBuildSystem {
        cmake = [ ];
        cython = [ ];
        ninja = [ ];
        scikit-build = [ ];
        scipy = [ ];
        setuptools = [ ];
        wheel = [ ];
      });
  }

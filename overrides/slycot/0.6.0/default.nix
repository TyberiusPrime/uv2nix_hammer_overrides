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
      pkgs.blas
      pkgs.lapack
    ];
  }
else
  {
    buildInputs = old.buildInputs or [ ] ++ [
      pkgs.blas
      pkgs.lapack
    ];
    nativeBuildInputs =
      old.nativeBuildInputs or [ ]
      ++ [ pkgs.gfortran ]
      ++ (resolveBuildSystem {
        cmake = [ ];
        numpy = [ ];
        scikit-build = [ ];
        setuptools = [ ];
        setuptools-scm = [ ];
        wheel = [ ];
      });
  }

{
  final,
  helpers,
  pkgs,
  resolveBuildSystem,
  ...
}:
old:
if (helpers.isWheel old) then
  {
    autoPatchelfIgnoreMissingDeps = true;
    buildInputs = old.buildInputs or [ ] ++ [ pkgs.cudaPackages.cuda_cudart ];
    preFixup = pkgs.lib.optionals (!pkgs.stdenv.isDarwin) ''
      addAutoPatchelfSearchPath "${final.torch}/${final.python.sitePackages}/torch/lib"
    '';
  }
else
  {
    buildInputs = old.buildInputs or [ ] ++ [ pkgs.cudaPackages.cuda_cudart ];
    nativeBuildInputs =
      old.nativeBuildInputs or [ ]
      ++ [
        final.torch
        pkgs.which
      ]
      ++ (resolveBuildSystem { setuptools = [ ]; });
  }

{
  final,
  helpers,
  pkgs,
  ...
}:
old:
if (helpers.isWheel old) then
  {
    autoPatchelfIgnoreMissingDeps = true;
    buildInputs =
      old.buildInputs or [ ]
      ++ (pkgs.lib.optionals (
        (builtins.trace pkgs.stdenv.hostPlatform.system pkgs.stdenv.hostPlatform.system) == "x86_64-linux"
      ) [ pkgs.cudaPackages.cuda_cudart ]);
    preFixup = pkgs.lib.optionals (!pkgs.stdenv.isDarwin) ''
      addAutoPatchelfSearchPath "${final.torch}/${final.python.sitePackages}/torch/lib"
    '';
  }
else
  {
    buildInputs =
      old.buildInputs or [ ]
      ++ (pkgs.lib.optionals (
        (builtins.trace pkgs.stdenv.hostPlatform.system pkgs.stdenv.hostPlatform.system) == "x86_64-linux"
      ) [ pkgs.cudaPackages.cuda_cudart ]);
  }

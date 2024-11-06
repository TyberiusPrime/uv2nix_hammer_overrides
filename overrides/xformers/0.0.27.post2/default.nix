{ final, pkgs, ... }:
old:
if ((old.passthru.format or "sdist") == "wheel") then
  {
    autoPatchelfIgnoreMissingDeps = true;
    buildInputs = old.buildInputs or [ ] ++ [ pkgs.cudaPackages.cuda_cudart ];
    preFixup = pkgs.lib.optionals (!pkgs.stdenv.isDarwin) ''
      addAutoPatchelfSearchPath "${final.torch}/${final.python.sitePackages}/torch/lib"
    '';
  }
else
  { buildInputs = old.buildInputs or [ ] ++ [ pkgs.cudaPackages.cuda_cudart ]; }
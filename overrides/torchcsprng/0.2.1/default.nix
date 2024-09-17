{ pkgs, final, ... }:
old:
if ((old.format or "sdist") == "wheel") then
  {
    autoPatchelfIgnoreMissingDeps = true;
    preFixup = pkgs.lib.optionals (!pkgs.stdenv.isDarwin) ''
      addAutoPatchelfSearchPath "${final.torch}/${final.python.sitePackages}/torch/lib"
    '';
  }
else
  { }

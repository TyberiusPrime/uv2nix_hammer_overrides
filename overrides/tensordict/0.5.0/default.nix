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
    preFixup = pkgs.lib.optionals (!pkgs.stdenv.isDarwin) ''
      addAutoPatchelfSearchPath "${final.torch}/${final.python.sitePackages}/torch/lib"
    '';
  }
else
  { }

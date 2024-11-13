{
  helpers,
  pkgs,
  final,
  ...
}:
old:
if (helpers.isWheel old) then
  {
    buildInputs = old.buildInputs or [ ] ++ [
      (pkgs.boost183.override {
        inherit (final) python;
        inherit (final) numpy;
        enablePython = true;
      })
      final.eigenpy
      pkgs.assimp
      pkgs.boost183
      pkgs.octomap
      pkgs.qhull
    ];
    preFixup = ''
      addAutoPatchelfSearchPath ${final.eigenpy}/${final.python.sitePackages}/cmeel.prefix/${final.python.sitePackages}
    '';
  }
else
  {
    buildInputs = old.buildInputs or [ ] ++ [
      (pkgs.boost183.override {
        inherit (final) python;
        inherit (final) numpy;
        enablePython = true;
      })
      final.eigenpy
      pkgs.assimp
      pkgs.boost183
      pkgs.octomap
      pkgs.qhull
    ];
  }

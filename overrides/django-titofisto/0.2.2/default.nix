{
  final,
  helpers,
  pkgs,
  resolveBuildSystem,
  ...
}:
old:
let
  funcs = [
    (
      old:
      old
      // (
        if (helpers.isWheel old) then
          { }
        else
          { nativeBuildInputs = old.nativeBuildInputs or [ ] ++ (resolveBuildSystem { poetry-core = [ ]; }); }
      )
    )
    (
      old:
      old
      // {
        postInstall =
          old.postInstall or ""
          + ''
            rm -rf $out/${final.python.sitePackages}/LICENSE
          '';
      }
    )
  ];
in
pkgs.lib.trivial.pipe old funcs

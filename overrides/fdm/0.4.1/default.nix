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
          {
            nativeBuildInputs =
              old.nativeBuildInputs or [ ]
              ++ (resolveBuildSystem {
                cython = [ ];
                numpy = [ ];
                setuptools = [ ];
                wheel = [ ];
              });
          }
      )
    )
    (
      old:
      old
      // {
        postInstall =
          old.postInstall or ""
          + ''
            rm $out/lib/python${final.python.pythonVersion}/site-packages/tests/* -r
          '';
      }
    )
  ];
in
pkgs.lib.trivial.pipe old funcs

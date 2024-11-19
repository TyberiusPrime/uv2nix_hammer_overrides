{
  final,
  helpers,
  pkgs,
  resolveBuildSystem,
  ...
}:
old:
if (helpers.isWheel old) then
  { }
else
  {
    nativeBuildInputs =
      old.nativeBuildInputs or [ ]
      ++ [
        (pkgs.boost.override {
          inherit (final) python;
          inherit (final) numpy;
          enablePython = true;
        })
        pkgs.exiv2
      ]
      ++ (resolveBuildSystem { setuptools = [ ]; });
  }

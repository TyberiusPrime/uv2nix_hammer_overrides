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
    dontUseCmakeConfigure = true;
    nativeBuildInputs =
      old.nativeBuildInputs or [ ]
      ++ [
        (pkgs.boost.override {
          inherit (final) python;
          inherit (final) numpy;
          enablePython = true;
        })
        pkgs.cmake
        pkgs.zlib.dev
      ]
      ++ (resolveBuildSystem { setuptools = [ ]; });
  }

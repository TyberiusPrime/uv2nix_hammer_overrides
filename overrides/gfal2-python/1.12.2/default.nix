{
  resolveBuildSystem,
  final,
  pkgs,
  ...
}:
old:
if ((old.passthru.format or "sdist") == "wheel") then
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
        pkgs.gfal2
        pkgs.glib
        pkgs.pcre2
        pkgs.pkg-config
      ]
      ++ (resolveBuildSystem { setuptools = [ ]; });
  }

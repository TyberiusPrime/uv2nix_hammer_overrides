{
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
        pkgs.openssl
        pkgs.swig
      ]
      ++ (resolveBuildSystem { setuptools = [ ]; });
  }

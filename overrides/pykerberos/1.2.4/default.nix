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
      old.nativeBuildInputs or [ ] ++ [ pkgs.libkrb5.dev ] ++ (resolveBuildSystem { setuptools = [ ]; });
  }

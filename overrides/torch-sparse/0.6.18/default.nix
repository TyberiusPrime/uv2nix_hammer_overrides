{
  resolveBuildSystem,
  helpers,
  final,
  ...
}:
old:
if (helpers.isWheel old) then
  { }
else
  {
    nativeBuildInputs =
      old.nativeBuildInputs or [ ] ++ [ final.torch ] ++ (resolveBuildSystem { setuptools = [ ]; });
  }

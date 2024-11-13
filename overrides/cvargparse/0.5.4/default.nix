{ resolveBuildSystem, final, ... }:
old:
if ((old.passthru.format or "sdist") == "wheel") then
  { }
else
  {
    nativeBuildInputs =
      old.nativeBuildInputs or [ ] ++ [ final.pip ] ++ (resolveBuildSystem { setuptools = [ ]; });
  }

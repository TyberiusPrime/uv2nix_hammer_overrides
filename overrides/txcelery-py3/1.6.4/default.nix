{ resolveBuildSystem, ... }:
old:
if ((old.passthru.format or "sdist") == "wheel") then
  { }
else
  {
    env = {
      dontCheckRuntimeDeps = true;
    };
    nativeBuildInputs = old.nativeBuildInputs or [ ] ++ (resolveBuildSystem { setuptools = [ ]; });
  }
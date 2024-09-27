{ resolveBuildSystem, ... }:
old:
if ((old.format or "sdist") == "wheel") then
  { }
else
  {
    nativeBuildInputs = old.nativeBuildInputs or [ ] ++ (resolveBuildSystem { setuptools = [ ]; });
    postPatch = (old.postPatch or "") + "touch /build/adapt-parser-1.0.0/requirements.txt";
  }

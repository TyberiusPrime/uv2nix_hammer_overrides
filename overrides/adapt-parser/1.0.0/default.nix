{ resolveBuildSystem, helpers, ... }:
old:
if (helpers.isWheel old) then
  { }
else
  {
    nativeBuildInputs = old.nativeBuildInputs or [ ] ++ (resolveBuildSystem { setuptools = [ ]; });
    postPatch = (old.postPatch or "") + "touch /build/adapt-parser-1.0.0/requirements.txt";
  }

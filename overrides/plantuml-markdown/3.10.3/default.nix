{ helpers, resolveBuildSystem, ... }:
old:
if (helpers.isWheel old) then
  { }
else
  {
    nativeBuildInputs = old.nativeBuildInputs or [ ] ++ (resolveBuildSystem { setuptools = [ ]; });
    postPatch = (old.postPatch or "") + "touch /build/plantuml-markdown-3.10.3/test-requirements.txt";
  }

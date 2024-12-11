{ helpers, resolveBuildSystem, ... }:
old:
if (helpers.isWheel old) then
  { }
else
  {
    nativeBuildInputs = old.nativeBuildInputs or [ ] ++ (resolveBuildSystem { setuptools = [ ]; });
    postPatch = (old.postPatch or "") + "touch /build/embedding_reader-1.7.0/requirements.txt";
  }

{ helpers, resolveBuildSystem, ... }:
old:
if (helpers.isWheel old) then
  { }
else
  {
    nativeBuildInputs = old.nativeBuildInputs or [ ] ++ (resolveBuildSystem { setuptools = [ ]; });
    unpackPhase = ''
      mkdir src/${old.pname}/${old.version} -p
      cd src/${old.pname}/${old.version} 
      unzip $src
    '';
  }

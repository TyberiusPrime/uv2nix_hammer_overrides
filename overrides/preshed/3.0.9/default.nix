{ helpers, resolveBuildSystem, ... }:
old:
if (helpers.isWheel old) then
  { }
else
  {
    nativeBuildInputs =
      old.nativeBuildInputs or [ ]
      ++ (resolveBuildSystem {
        cymem = [ ];
        cython = [ ];
        murmurhash = [ ];
        setuptools = [ ];
      });
  }

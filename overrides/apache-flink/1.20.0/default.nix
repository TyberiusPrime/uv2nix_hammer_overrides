{ helpers, resolveBuildSystem, ... }:
old:
if (helpers.isWheel old) then
  { }
else
  {
    nativeBuildInputs =
      old.nativeBuildInputs or [ ]
      ++ (resolveBuildSystem {
        apache-beam = [ ];
        cython = [ ];
        fastavro = [ ];
        packaging = [ ];
        setuptools = [ ];
        wheel = [ ];
      });
  }

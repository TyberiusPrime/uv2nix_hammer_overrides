{ helpers, resolveBuildSystem, ... }:
old:
if (helpers.isWheel old) then
  { }
else
  {
    nativeBuildInputs =
      old.nativeBuildInputs or [ ]
      ++ (resolveBuildSystem {
        cmake = [ ];
        cython = [ ];
        numpy = [ ];
        poetry-core = [ ];
        setuptools = [ ];
      });
  }

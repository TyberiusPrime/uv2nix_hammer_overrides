{ helpers, resolveBuildSystem, ... }:
old:
if (helpers.isWheel old) then
  { }
else
  {
    nativeBuildInputs =
      old.nativeBuildInputs or [ ]
      ++ (resolveBuildSystem {
        cython = [ ];
        oldest-supported-numpy = [ ];
        setuptools = [ ];
        setuptools-scm = [ ];
        wheel = [ ];
      });
  }

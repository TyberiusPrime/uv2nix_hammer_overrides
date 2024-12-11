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
        numpy = [ ];
        oldest-supported-numpy = [ ];
        qdldl = [ ];
        setuptools = [ ];
        setuptools-scm = [ ];
        wheel = [ ];
      });
  }

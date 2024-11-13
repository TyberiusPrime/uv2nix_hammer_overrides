{ resolveBuildSystem, helpers, ... }:
old:
if (helpers.isWheel old) then
  { }
else
  {
    nativeBuildInputs =
      old.nativeBuildInputs or [ ]
      ++ (resolveBuildSystem {
        blosc2 = [ ];
        cython = [ ];
        oldest-supported-numpy = [ ];
        packaging = [ ];
        py-cpuinfo = [ ];
        setuptools = [ ];
        wheel = [ ];
      });
  }

{ resolveBuildSystem, helpers, ... }:
old:
if (helpers.isWheel old) then
  { }
else
  {
    nativeBuildInputs =
      old.nativeBuildInputs or [ ]
      ++ (resolveBuildSystem {
        ninja = [ ];
        pybind11 = [ ];
        setuptools = [ ];
        wheel = [ ];
      });
  }

{ resolveBuildSystem, ... }:
old:
if ((old.passthru.format or "sdist") == "wheel") then
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

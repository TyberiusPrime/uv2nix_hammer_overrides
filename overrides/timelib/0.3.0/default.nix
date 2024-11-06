{ resolveBuildSystem, ... }:
old:
if ((old.passthru.format or "sdist") == "wheel") then
  { }
else
  {
    nativeBuildInputs =
      old.nativeBuildInputs or [ ]
      ++ (resolveBuildSystem {
        cython = [ ];
        setuptools = [ ];
      });
  }
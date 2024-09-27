{ resolveBuildSystem, ... }:
old:
if ((old.format or "sdist") == "wheel") then
  { }
else
  {
    nativeBuildInputs =
      old.nativeBuildInputs or [ ]
      ++ (resolveBuildSystem {
        setuptools = [ ];
        setuptools-git = [ ];
        setuptools-scm = [ ];
      });
  }

{ resolveBuildSystem, ... }:
old:
if ((old.format or "sdist") == "wheel") then
  { }
else
  {
    env = {
      dontCheckRuntimeDeps = true;
    };
    nativeBuildInputs =
      old.nativeBuildInputs or [ ]
      ++ (resolveBuildSystem {
        "cython_0" = [ ];
        oldest-supported-numpy = [ ];
        setuptools = [ ];
        setuptools-scm = [ ];
        wheel = [ ];
      });
  }

{ final, ... }:
old:
if ((old.format or "sdist") == "wheel") then
  { }
else
  {
    env = {
      dontCheckRuntimeDeps = true;
    };
    nativeBuildInputs = old.nativeBuildInputs or [ ] ++ [
      final.wheel
      final.setuptools-scm
      final.cython_0
      final.oldest-supported-numpy
      final.setuptools
    ];
  }

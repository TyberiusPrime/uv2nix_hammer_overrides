{ final, ... }:
old:
if ((old.format or "sdist") == "wheel") then
  { }
else
  {
    nativeBuildInputs = old.nativeBuildInputs or [ ] ++ [
      final.wheel
      final.extension-helpers
      final.setuptools-scm
      final.oldest-supported-numpy
      final.cython
      final.setuptools
    ];
  }

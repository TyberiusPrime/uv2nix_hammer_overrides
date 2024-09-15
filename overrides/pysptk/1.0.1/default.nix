{ final, ... }:
old:
if ((old.format or "sdist") == "wheel") then
  { }
else
  {
    nativeBuildInputs = old.nativeBuildInputs or [ ] ++ [
      final.wheel
      final.scipy
      final.cython
      final.numpy
      final.setuptools
    ];
  }

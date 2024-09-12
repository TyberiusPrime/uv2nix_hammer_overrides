{ final, ... }:
old:
if ((old.format or "sdist") == "wheel") then
  { }
else
  {
    nativeBuildInputs = old.nativeBuildInputs or [ ] ++ [
      final.cython_0
      final.setuptools
      final.wheel
      final.oldest-supported-numpy
    ];
  }

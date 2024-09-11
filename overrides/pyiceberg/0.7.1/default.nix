{ final, ... }:
old:
if ((old.format or "sdist") == "wheel") then
  { }
else
  {
    nativeBuildInputs = old.nativeBuildInputs or [ ] ++ [
      final.poetry-core
      final.cython
      final.setuptools
      final.wheel
    ];
  }

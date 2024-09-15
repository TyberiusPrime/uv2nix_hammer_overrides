{ final, ... }:
old:
if ((old.format or "sdist") == "wheel") then
  { }
else
  {
    nativeBuildInputs = old.nativeBuildInputs or [ ] ++ [
      final.setuptools-scm
      final.setuptools
      final.tomli
      final.wheel
    ];
  }

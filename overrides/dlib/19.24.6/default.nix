{ final, pkgs, ... }:
old:
if ((old.format or "sdist") == "wheel") then
  { }
else
  {
    dontUseCmakeConfigure = true;
    nativeBuildInputs =
      old.nativeBuildInputs or [ ]
      ++ [ pkgs.cmake ]
      ++ [
        final.setuptools
        final.wheel
      ];
  }

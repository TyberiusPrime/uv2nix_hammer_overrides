{ resolveBuildSystem, pkgs, ... }:
old:
if ((old.format or "sdist") == "wheel") then
  { }
else
  {
    dontUseCmakeConfigure = true;
    nativeBuildInputs =
      old.nativeBuildInputs or [ ]
      ++ [ pkgs.cmake ]
      ++ (resolveBuildSystem {
        setuptools = [ ];
        wheel = [ ];
      });
  }

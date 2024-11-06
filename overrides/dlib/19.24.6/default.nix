{ resolveBuildSystem, pkgs, ... }:
old:
if ((old.passthru.format or "sdist") == "wheel") then
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
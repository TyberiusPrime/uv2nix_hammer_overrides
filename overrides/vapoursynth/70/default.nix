{ resolveBuildSystem, pkgs, ... }:
old:
if ((old.passthru.format or "sdist") == "wheel") then
  { }
else
  {
    nativeBuildInputs =
      old.nativeBuildInputs or [ ]
      ++ [ pkgs.vapoursynth ]
      ++ (resolveBuildSystem {
        cython = [ ];
        setuptools = [ ];
      });
  }

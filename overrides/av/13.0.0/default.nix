{ resolveBuildSystem, pkgs, ... }:
old:
if ((old.passthru.format or "sdist") == "wheel") then
  { buildInputs = old.buildInputs or [ ] ++ [ pkgs.ffmpeg ]; }
else
  {
    buildInputs = old.buildInputs or [ ] ++ [ pkgs.ffmpeg ];
    nativeBuildInputs =
      old.nativeBuildInputs or [ ]
      ++ [ pkgs.pkg-config ]
      ++ (resolveBuildSystem {
        cython = [ ];
        setuptools = [ ];
      });
  }

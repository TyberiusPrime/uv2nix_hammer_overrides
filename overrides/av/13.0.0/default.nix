{ final, pkgs, ... }:
old:
if ((old.format or "sdist") == "wheel") then
  { buildInputs = old.buildInputs or [ ] ++ [ pkgs.ffmpeg ]; }
else
  {
    buildInputs = old.buildInputs or [ ] ++ [ pkgs.ffmpeg ];
    nativeBuildInputs =
      old.nativeBuildInputs or [ ]
      ++ [ pkgs.pkg-config ]
      ++ [
        final.cython
        final.setuptools
      ];
  }

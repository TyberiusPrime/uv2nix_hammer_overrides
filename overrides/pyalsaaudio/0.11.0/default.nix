{ final, pkgs, ... }:
old:
if ((old.format or "sdist") == "wheel") then
  { buildInputs = old.buildInputs or [ ] ++ [ pkgs.alsa-lib ]; }
else
  {
    buildInputs = old.buildInputs or [ ] ++ [ pkgs.alsa-lib ];
    nativeBuildInputs = old.nativeBuildInputs or [ ] ++ [ final.setuptools ];
  }

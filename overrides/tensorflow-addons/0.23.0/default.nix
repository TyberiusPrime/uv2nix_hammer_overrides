{ pkgs, ... }:
old:
if ((old.format or "sdist") == "wheel") then
  { buildInputs = old.buildInputs or [ ] ++ [ pkgs.libtensorflow ]; }
else
  { buildInputs = old.buildInputs or [ ] ++ [ pkgs.libtensorflow ]; }

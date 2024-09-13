{ pkgs, ... }:
old:
if ((old.format or "sdist") == "wheel") then
  { buildInputs = old.buildInputs or [ ] ++ [ pkgs.SDL2 ]; }
else
  { buildInputs = old.buildInputs or [ ] ++ [ pkgs.SDL2 ]; }

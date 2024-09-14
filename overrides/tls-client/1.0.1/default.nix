{ pkgs, ... }:
old:
if ((old.format or "sdist") == "wheel") then
  { buildInputs = old.buildInputs or [ ] ++ [ pkgs.musl ]; }
else
  { buildInputs = old.buildInputs or [ ] ++ [ pkgs.musl ]; }

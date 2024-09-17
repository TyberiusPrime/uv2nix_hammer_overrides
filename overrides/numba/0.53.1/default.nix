{ pkgs, ... }:
old:
if ((old.format or "sdist") == "wheel") then
  { buildInputs = old.buildInputs or [ ] ++ [ pkgs.tbb.out ]; }
else
  { buildInputs = old.buildInputs or [ ] ++ [ pkgs.tbb.out ]; }

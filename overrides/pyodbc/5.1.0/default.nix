{ pkgs, ... }:
old:
if ((old.format or "sdist") == "wheel") then
  { buildInputs = old.buildInputs or [ ] ++ [ pkgs.unixODBC ]; }
else
  { buildInputs = old.buildInputs or [ ] ++ [ pkgs.unixODBC ]; }

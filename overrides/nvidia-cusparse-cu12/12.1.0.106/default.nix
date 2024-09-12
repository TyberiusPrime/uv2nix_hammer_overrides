{ pkgs, ... }:
old:
if ((old.format or "sdist") == "wheel") then
  { buildInputs = old.buildInputs or [ ] ++ [ pkgs.cudaPackages.libnvjitlink ]; }
else
  {
    buildInputs = old.buildInputs or [ ] ++ [ pkgs.cudaPackages.libnvjitlink ];
    env = { };
  }

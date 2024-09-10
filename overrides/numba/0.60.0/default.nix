{ pkgs, ... }:
old:
if ((old.format or "sdist") == "wheel") then
  { buildInputs = old.buildInputs or [ ] ++ [ pkgs.tbb_2021_11.out ]; }
else
  {
    buildInputs = old.buildInputs or [ ] ++ [ pkgs.tbb_2021_11.out ];
    env = { };
  }

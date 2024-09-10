{ final, pkgs, ... }:
old:
if ((old.format or "sdist") == "wheel") then
  { buildInputs = old.buildInputs or [ ] ++ [ pkgs.systemd ]; }
else
  {
    buildInputs = old.buildInputs or [ ] ++ [ pkgs.systemd ];
    env = { };
    nativeBuildInputs = old.nativeBuildInputs or [ ] ++ [ pkgs.pkg-config ] ++ [ final.setuptools ];
  }

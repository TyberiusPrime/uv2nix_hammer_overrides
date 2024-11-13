{ resolveBuildSystem, pkgs, ... }:
old:
if ((old.passthru.format or "sdist") == "wheel") then
  { buildInputs = old.buildInputs or [ ] ++ [ pkgs.systemd ]; }
else
  {
    buildInputs = old.buildInputs or [ ] ++ [ pkgs.systemd ];
    nativeBuildInputs =
      old.nativeBuildInputs or [ ] ++ [ pkgs.pkg-config ] ++ (resolveBuildSystem { setuptools = [ ]; });
  }

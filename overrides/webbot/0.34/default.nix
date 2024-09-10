{ pkgs, ... }:
old:
if ((old.format or "sdist") == "wheel") then
  {
    buildInputs = old.buildInputs or [ ] ++ [
      pkgs.glib
      pkgs.nspr
      pkgs.nss
      pkgs.xorg.libX11
    ];
  }
else
  {
    buildInputs = old.buildInputs or [ ] ++ [
      pkgs.glib
      pkgs.nspr
      pkgs.nss
      pkgs.xorg.libX11
    ];
    env = { };
  }

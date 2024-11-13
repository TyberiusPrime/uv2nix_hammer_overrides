{ pkgs, ... }:
old: {
  buildInputs = old.buildInputs or [ ] ++ [
    pkgs.glib
    pkgs.nspr
    pkgs.nss
    pkgs.xorg.libX11
  ];
}

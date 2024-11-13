{ pkgs, ... }:
old: {
  buildInputs = old.buildInputs or [ ] ++ [
    pkgs.glibc
    pkgs.libxcrypt
    pkgs.libxcrypt-legacy
    pkgs.linux-pam
  ];
}

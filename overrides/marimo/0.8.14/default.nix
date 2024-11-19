{ pkgs, ... }: old: { buildInputs = old.buildInputs or [ ] ++ [ pkgs.krb5 ]; }

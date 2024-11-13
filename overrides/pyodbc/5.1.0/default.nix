{ pkgs, ... }: old: { buildInputs = old.buildInputs or [ ] ++ [ pkgs.unixODBC ]; }

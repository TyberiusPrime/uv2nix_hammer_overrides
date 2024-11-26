{ pkgs, ... }: old: { buildInputs = old.buildInputs or [ ] ++ [ pkgs.zlib ]; }

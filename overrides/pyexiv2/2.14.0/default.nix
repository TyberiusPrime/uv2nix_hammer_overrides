{ pkgs, ... }: old: { buildInputs = old.buildInputs or [ ] ++ [ pkgs.exiv2 ]; }

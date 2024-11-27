{ pkgs, ... }: old: { buildInputs = old.buildInputs or [ ] ++ [ pkgs.cudaPackages_11.libcublas ]; }

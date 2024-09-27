{ pkgs, ... }: old: { buildInputs = old.buildInputs or [ ] ++ [ pkgs.cudaPackages.libnvjitlink ]; }

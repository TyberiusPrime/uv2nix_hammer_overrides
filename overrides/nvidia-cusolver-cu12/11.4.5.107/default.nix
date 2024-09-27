{ pkgs, ... }:
old: {
  buildInputs = old.buildInputs or [ ] ++ [
    pkgs.cudaPackages.libcublas
    pkgs.cudaPackages.libcusparse
    pkgs.cudaPackages.libnvjitlink
  ];
}

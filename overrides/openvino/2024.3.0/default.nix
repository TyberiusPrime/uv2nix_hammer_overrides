{ pkgs, ... }:
old: {
  buildInputs = old.buildInputs or [ ] ++ [
    pkgs.level-zero
    pkgs.ocl-icd
  ];
}

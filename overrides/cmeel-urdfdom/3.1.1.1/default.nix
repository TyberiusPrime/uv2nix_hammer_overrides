{ pkgs, ... }:
old: {
  buildInputs = old.buildInputs or [ ] ++ [
    pkgs.console-bridge
    pkgs.tinyxml
  ];
}

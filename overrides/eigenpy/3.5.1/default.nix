{ pkgs, final, ... }:
old: {
  buildInputs = old.buildInputs or [ ] ++ [
    (pkgs.boost183.override {
      inherit (final) python;
      inherit (final) numpy;
      enablePython = true;
    })
    pkgs.boost183
  ];
}

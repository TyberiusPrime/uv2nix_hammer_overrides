{ resolveBuildSystem, pkgs, ... }:
old:
if ((old.passthru.format or "sdist") == "wheel") then
  {
    buildInputs = old.buildInputs or [ ] ++ [
      pkgs.cyrus_sasl
      pkgs.openldap.dev
      pkgs.pkg-config
    ];
  }
else
  {
    buildInputs = old.buildInputs or [ ] ++ [
      pkgs.cyrus_sasl
      pkgs.openldap.dev
      pkgs.pkg-config
    ];
    nativeBuildInputs = old.nativeBuildInputs or [ ] ++ (resolveBuildSystem { setuptools = [ ]; });
  }

{
  helpers,
  pkgs,
  resolveBuildSystem,
  ...
}:
old:
if (helpers.isWheel old) then
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
    nativeBuildInputs =
      old.nativeBuildInputs or [ ]
      ++ (resolveBuildSystem {
        setuptools = [ ];
        wheel = [ ];
      });
  }

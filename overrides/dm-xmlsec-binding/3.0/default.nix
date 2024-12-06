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
      pkgs.libtool
      pkgs.xmlsec.dev
    ];
  }
else
  {
    buildInputs = old.buildInputs or [ ] ++ [
      pkgs.libtool
      pkgs.xmlsec.dev
    ];
    nativeBuildInputs =
      old.nativeBuildInputs or [ ]
      ++ [
        pkgs.libxml2
        pkgs.xmlsec.out
      ]
      ++ (resolveBuildSystem {
        lxml = [ ];
        setuptools = [ ];
      });
  }

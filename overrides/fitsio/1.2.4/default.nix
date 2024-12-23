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
      pkgs.cfitsio
      pkgs.curl
      pkgs.zlib.out
    ];
  }
else
  {
    buildInputs = old.buildInputs or [ ] ++ [
      pkgs.cfitsio
      pkgs.curl
      pkgs.zlib.out
    ];
    nativeBuildInputs =
      old.nativeBuildInputs or [ ]
      ++ [
        pkgs.bzip2.dev
        pkgs.pkg-config
      ]
      ++ (resolveBuildSystem {
        numpy = [ ];
        setuptools = [ ];
      });
  }

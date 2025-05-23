{
  helpers,
  pkgs,
  resolveBuildSystem,
  ...
}:
old:
if (helpers.isWheel old) then
  { buildInputs = old.buildInputs or [ ] ++ [ pkgs.gdal ]; }
else
  {
    buildInputs = old.buildInputs or [ ] ++ [ pkgs.gdal ];
    nativeBuildInputs =
      old.nativeBuildInputs or [ ]
      ++ [ pkgs.gdal ]
      ++ (resolveBuildSystem {
        cython = [ ];
        numpy = [ ];
        oldest-supported-numpy = [ ];
        setuptools = [ ];
        wheel = [ ];
      });
  }

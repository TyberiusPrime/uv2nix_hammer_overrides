{
  helpers,
  pkgs,
  resolveBuildSystem,
  ...
}:
old:
if (helpers.isWheel old) then
  { buildInputs = old.buildInputs or [ ] ++ [ pkgs.hdf5 ]; }
else
  {
    buildInputs = old.buildInputs or [ ] ++ [ pkgs.hdf5 ];
    nativeBuildInputs =
      old.nativeBuildInputs or [ ]
      ++ (resolveBuildSystem {
        "cython_0" = [ ];
        oldest-supported-numpy = [ ];
        pkgconfig = [ ];
        setuptools = [ ];
        wheel = [ ];
      });
  }

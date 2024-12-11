{
  final,
  helpers,
  pkgs,
  resolveBuildSystem,
  ...
}:
old:
if (helpers.isWheel old) then
  { }
else
  {
    buildInputs = old.buildInputs or [ ] ++ [ pkgs.c-blosc2 ];
    env = {
      "HDF5_DIR" = pkgs.lib.getDev pkgs.hdf5;
    };
    nativeBuildInputs =
      old.nativeBuildInputs or [ ]
      ++ [
        final.blosc2
        pkgs.hdf5
        pkgs.pkg-config
      ]
      ++ (resolveBuildSystem {
        blosc2 = [ ];
        cython = [ ];
        numpy = [ ];
        packaging = [ ];
        py-cpuinfo = [ ];
        setuptools = [ ];
        typing-extensions = [ ];
        wheel = [ ];
      });
  }

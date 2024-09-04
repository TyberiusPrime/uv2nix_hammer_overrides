{ final, pkgs, ... }:
old:
if ((old.format or "sdist") == "wheel") then
  { buildInputs = old.buildInputs or [ ] ++ [ pkgs.hdf5 ]; }
else
  {
    buildInputs = old.buildInputs or [ ] ++ [ pkgs.hdf5 ];
    nativeBuildInputs = old.nativeBuildInputs or [ ] ++ [
      final.setuptools
      final.numpy
      final.oldest-supported-numpy
      final.cython
      final.pkgconfig
      final.setuptools
    ];
  }

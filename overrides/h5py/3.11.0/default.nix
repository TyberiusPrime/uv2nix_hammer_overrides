{resolveBuildSystem, helpers, final, pkgs, ...}
        : old: if (helpers.isWheel old) then {buildInputs = old.buildInputs or [] ++ [pkgs.hdf5];} else {buildInputs = old.buildInputs or [] ++ [pkgs.hdf5];nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {cython = [];numpy = [];oldest-supported-numpy = [];pkgconfig = [];setuptools = [];});}
        
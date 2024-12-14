{final, helpers, pkgs, resolveBuildSystem, ...}
        : old: if (helpers.isWheel old) then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ [pkgs.gfortran pkgs.meson pkgs.pkg-config] ++ ( resolveBuildSystem {meson-python = [];ninja = [];oldest-supported-numpy = [];wheel = [];});}
        
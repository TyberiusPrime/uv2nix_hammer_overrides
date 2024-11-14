{final, helpers, pkgs, resolveBuildSystem, ...}
        : old: if (helpers.isWheel old) then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ [pkgs.djvulibre pkgs.pkg-config] ++ ( resolveBuildSystem {"cython_0" = [];setuptools = [];wheel = [];});}
        
{resolveBuildSystem, final, pkgs, ...}
        : old: if ((old.passthru.format or "sdist") == "wheel") then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ [pkgs.djvulibre pkgs.pkg-config] ++ ( resolveBuildSystem {"cython_0" = [];setuptools = [];wheel = [];});}
        
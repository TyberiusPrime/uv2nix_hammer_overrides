{final, helpers, pkgs, resolveBuildSystem, ...}
        : old: if (helpers.isWheel old) then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ [pkgs.meson] ++ ( resolveBuildSystem {cython = [];meson-python = [];ninja = [];numpy = [];packaging = [];wheel = [];});}
        
{final, helpers, pkgs, resolveBuildSystem, ...}
        : old: if (helpers.isWheel old) then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ [pkgs.gtk3 pkgs.pkg-config pkgs.which] ++ ( resolveBuildSystem {setuptools = [];wheel = [];});}
        
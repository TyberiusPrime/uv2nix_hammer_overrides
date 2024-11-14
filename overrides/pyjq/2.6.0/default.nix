{final, helpers, pkgs, resolveBuildSystem, ...}
        : old: if (helpers.isWheel old) then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ [pkgs.autoconf pkgs.automake pkgs.libtool pkgs.pkg-config] ++ ( resolveBuildSystem {setuptools = [];});}
        
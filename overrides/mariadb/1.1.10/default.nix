{resolveBuildSystem, helpers, final, pkgs, ...}
        : old: if (helpers.isWheel old) then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ [pkgs.libmysqlclient] ++ ( resolveBuildSystem {packaging = [];setuptools = [];wheel = [];});}
        
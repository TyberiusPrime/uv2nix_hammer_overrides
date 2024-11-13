{resolveBuildSystem, helpers, final, pkgs, ...}
        : old: if (helpers.isWheel old) then {buildInputs = old.buildInputs or [] ++ [pkgs.libmysqlclient];} else {buildInputs = old.buildInputs or [] ++ [pkgs.libmysqlclient];nativeBuildInputs = old.nativeBuildInputs or [] ++ [pkgs.libmysqlclient pkgs.pkg-config] ++ ( resolveBuildSystem {setuptools = [];});}
        
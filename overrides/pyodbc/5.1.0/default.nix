{final, helpers, pkgs, resolveBuildSystem, ...}
        : old: if (helpers.isWheel old) then {buildInputs = old.buildInputs or [] ++ [pkgs.unixODBC];} else {buildInputs = old.buildInputs or [] ++ [pkgs.unixODBC];nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {setuptools = [];});}
        
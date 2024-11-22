{final, helpers, pkgs, resolveBuildSystem, ...}
        : old: if (helpers.isWheel old) then {buildInputs = old.buildInputs or [] ++ [pkgs.libunwind];} else {buildInputs = old.buildInputs or [] ++ [pkgs.libunwind];nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {setuptools = [];});}
        
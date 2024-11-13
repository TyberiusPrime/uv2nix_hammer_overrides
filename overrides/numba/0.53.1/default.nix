{resolveBuildSystem, helpers, final, pkgs, ...}
        : old: if (helpers.isWheel old) then {buildInputs = old.buildInputs or [] ++ [pkgs.tbb.out];} else {buildInputs = old.buildInputs or [] ++ [pkgs.tbb.out];nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {setuptools = [];});}
        
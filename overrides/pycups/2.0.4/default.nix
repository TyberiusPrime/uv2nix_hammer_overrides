{resolveBuildSystem, helpers, final, pkgs, ...}
        : old: if (helpers.isWheel old) then {buildInputs = old.buildInputs or [] ++ [pkgs.cups];} else {buildInputs = old.buildInputs or [] ++ [pkgs.cups];nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {setuptools = [];});}
        
{resolveBuildSystem, final, pkgs, ...}
        : old: if ((old.passthru.format or "sdist") == "wheel") then {buildInputs = old.buildInputs or [] ++ [pkgs.cracklib];} else {buildInputs = old.buildInputs or [] ++ [pkgs.cracklib];nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {setuptools = [];});}
        
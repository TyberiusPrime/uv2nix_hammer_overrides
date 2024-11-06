{resolveBuildSystem, final, pkgs, ...}
        : old: if ((old.passthru.format or "sdist") == "wheel") then {buildInputs = old.buildInputs or [] ++ [pkgs.gammu];} else {buildInputs = old.buildInputs or [] ++ [pkgs.gammu];nativeBuildInputs = old.nativeBuildInputs or [] ++ [pkgs.pkg-config] ++ ( resolveBuildSystem {setuptools = [];});}
        
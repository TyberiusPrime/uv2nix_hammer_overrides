{resolveBuildSystem, final, pkgs, ...}
        : old: if ((old.passthru.format or "sdist") == "wheel") then {buildInputs = old.buildInputs or [] ++ [pkgs.cups];} else {buildInputs = old.buildInputs or [] ++ [pkgs.cups];nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {setuptools = [];});}
        
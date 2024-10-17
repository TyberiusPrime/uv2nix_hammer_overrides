{resolveBuildSystem, final, pkgs, ...}
        : old: if ((old.format or "sdist") == "wheel") then {buildInputs = old.buildInputs or [] ++ [pkgs.zlib];} else {buildInputs = old.buildInputs or [] ++ [pkgs.zlib];nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {setuptools = [];});}
        
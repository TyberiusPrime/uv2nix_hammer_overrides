{resolveBuildSystem, final, pkgs, ...}
        : old: if ((old.passthru.format or "sdist") == "wheel") then {buildInputs = old.buildInputs or [] ++ [pkgs.cyrus_sasl];} else {buildInputs = old.buildInputs or [] ++ [pkgs.cyrus_sasl];nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {setuptools = [];});}
        
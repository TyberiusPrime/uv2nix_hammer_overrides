{final, helpers, pkgs, resolveBuildSystem, ...}
        : old: if (helpers.isWheel old) then {buildInputs = old.buildInputs or [] ++ [pkgs.libffi];} else {buildInputs = old.buildInputs or [] ++ [pkgs.libffi];nativeBuildInputs = old.nativeBuildInputs or [] ++ [pkgs.pkg-config] ++ ( resolveBuildSystem {setuptools = [];});}
        
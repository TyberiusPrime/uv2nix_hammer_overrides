{final, helpers, pkgs, resolveBuildSystem, ...}
        : old: if (helpers.isWheel old) then {buildInputs = old.buildInputs or [] ++ [pkgs.openssl];} else {buildInputs = old.buildInputs or [] ++ [pkgs.openssl];nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {cmake = [];cython = [];setuptools = [];wheel = [];});}
        
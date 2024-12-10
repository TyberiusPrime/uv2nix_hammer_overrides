{final, helpers, pkgs, resolveBuildSystem, ...}
        : old: if (helpers.isWheel old) then {} else {dontUseCmakeConfigure = true;nativeBuildInputs = old.nativeBuildInputs or [] ++ [pkgs.cmake] ++ ( resolveBuildSystem {setuptools = [];});}
        
{final, helpers, resolveBuildSystem, ...}
        : old: if (helpers.isWheel old) then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ [final.torch] ++ ( resolveBuildSystem {setuptools = [];});}
        
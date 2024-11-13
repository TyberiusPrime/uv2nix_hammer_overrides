{resolveBuildSystem, helpers, final, ...}
        : old: if (helpers.isWheel old) then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {cmake = [];"cython_0" = [];ninja = [];oldest-supported-numpy = [];scikit-build = [];setuptools = [];});}
        
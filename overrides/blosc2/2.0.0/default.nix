{resolveBuildSystem, final, ...}
        : old: if ((old.passthru.format or "sdist") == "wheel") then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {cmake = [];"cython_0" = [];ninja = [];oldest-supported-numpy = [];scikit-build = [];setuptools = [];});}
        
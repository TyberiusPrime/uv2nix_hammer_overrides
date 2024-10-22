{resolveBuildSystem, final, ...}
        : old: if ((old.format or "sdist") == "wheel") then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {cmake = [];cython = [];ninja = [];oldest-supported-numpy = [];scikit-build = [];setuptools = [];});}
        
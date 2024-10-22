{resolveBuildSystem, final, ...}
        : old: if ((old.format or "sdist") == "wheel") then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {blosc2 = [];cython = [];oldest-supported-numpy = [];packaging = [];py-cpuinfo = [];setuptools = [];wheel = [];});}
        
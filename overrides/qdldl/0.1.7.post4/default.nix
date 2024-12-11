{final, helpers, resolveBuildSystem, ...}
        : old: if (helpers.isWheel old) then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {cmake = [];numpy = [];oldest-supported-numpy = [];pybind11 = [];setuptools = [];});}
        
{final, helpers, resolveBuildSystem, ...}
        : old: if (helpers.isWheel old) then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {numpy = [];pybind11 = [];setuptools = [];setuptools-scm = [];wheel = [];});}
        
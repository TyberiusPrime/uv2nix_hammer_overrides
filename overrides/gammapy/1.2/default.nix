{resolveBuildSystem, helpers, final, ...}
        : old: if (helpers.isWheel old) then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {cython = [];extension-helpers = [];oldest-supported-numpy = [];setuptools = [];setuptools-scm = [];wheel = [];});}
        
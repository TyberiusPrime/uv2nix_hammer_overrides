{final, helpers, resolveBuildSystem, ...}
        : old: if (helpers.isWheel old) then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {cython = [];extension-helpers = [];numpy = [];setuptools = [];setuptools-scm = [];});}
        
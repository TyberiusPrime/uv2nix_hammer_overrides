{final, helpers, resolveBuildSystem, ...}
        : old: if (helpers.isWheel old) then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {build = [];numpy = [];oldest-supported-numpy = [];pip = [];setuptools = [];setuptools-scm = [];wheel = [];});}
        
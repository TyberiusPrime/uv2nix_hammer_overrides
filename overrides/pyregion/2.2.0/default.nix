{resolveBuildSystem, final, helpers, ...}
        : old: if (helpers.isWheel old) then {} else {env = {dontCheckRuntimeDeps = true;};nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {"cython_0" = [];oldest-supported-numpy = [];setuptools = [];setuptools-scm = [];wheel = [];});}
        
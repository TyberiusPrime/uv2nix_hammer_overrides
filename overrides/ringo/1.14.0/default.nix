{final, helpers, resolveBuildSystem, ...}
        : old: if (helpers.isWheel old) then {} else {env = {dontCheckRuntimeDeps = true;};nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {setuptools = [];});}
        
{final, helpers, resolveBuildSystem, ...}
        : old: if (helpers.isWheel old) then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {setuptools = [];});postPatch = (old.postPatch or "")+("touch /build/ontospy-2.1.1/requirements.txt");}
        
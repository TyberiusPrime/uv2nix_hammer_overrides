{final, helpers, resolveBuildSystem, ...}
        : old: if (helpers.isWheel old) then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {setuptools = [];});postPatch = (old.postPatch or "")+("touch /build/yamlconf-0.2.6/requirements.txt");}
        
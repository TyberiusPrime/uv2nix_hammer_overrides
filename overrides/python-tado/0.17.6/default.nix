{final, helpers, resolveBuildSystem, ...}
        : old: if (helpers.isWheel old) then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {setuptools = [];});postPatch = (old.postPatch or "")+("touch /build/python_tado-0.17.6/requirements.txt");}
        
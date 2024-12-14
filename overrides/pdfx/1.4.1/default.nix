{final, helpers, resolveBuildSystem, ...}
        : old: if (helpers.isWheel old) then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {setuptools = [];});postPatch = (old.postPatch or "")+("touch /build/pdfx-1.4.1/requirements.txt");}
        
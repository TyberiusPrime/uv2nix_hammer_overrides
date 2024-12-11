{final, helpers, resolveBuildSystem, ...}
        : old: if (helpers.isWheel old) then {dontWrapQtApps = true;} else {dontWrapQtApps = true;nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {setuptools = [];});postPatch = (old.postPatch or "")+("touch requirements.txt");}
        
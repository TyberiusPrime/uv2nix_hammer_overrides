{resolveBuildSystem, final, helpers, ...}
        : old: if ((old.format or "sdist") == "wheel") then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {jupyter-packaging = [];setuptools = [];versioneer-518 = [];wheel = [];});postPatch = (old.postPatch or "")+(''
                ${helpers.tomlreplace} pyproject.toml build-system.requires "[]"
        '');}
        
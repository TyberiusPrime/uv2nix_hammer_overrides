{final, helpers, ...}
        : old: if ((old.format or "sdist") == "wheel") then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ [final.setuptools final.tomlkit];postPatch = (old.postPatch or "")+''
                ${helpers.tomlreplace} pyproject.toml build-system.requires "[]"
        '';}
        
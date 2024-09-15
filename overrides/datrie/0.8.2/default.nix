{final, helpers, ...}
        : old: if ((old.format or "sdist") == "wheel") then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ [final.pytest-runner final.cython_0 final.setuptools final.wheel];postPatch = (old.postPatch or "")+''
                ${helpers.tomlreplace} pyproject.toml build-system.requires "[]"
        '';}
        
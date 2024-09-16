{final, helpers, ...}
        : old: if ((old.format or "sdist") == "wheel") then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ [final.jupyterlab final.setuptools final.jupyter-packaging final.wheel];postPatch = (old.postPatch or "")+''
                ${helpers.tomlreplace} pyproject.toml build-system.requires "[]"
        '';}
        
{final, helpers, ...}
        : old: if ((old.format or "sdist") == "wheel") then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ [final.poetry-core];postPatch = (old.postPatch or "")+''
                    substituteInPlace pyproject.toml --replace-fail "poetry.masonry.api" "poetry.core.masonry.api"
                ''+''
                ${helpers.tomlreplace} pyproject.toml build-system.requires "[]"
        '';}
        
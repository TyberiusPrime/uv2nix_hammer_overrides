{resolveBuildSystem, final, helpers, ...}
        : old: if (helpers.isWheel old) then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {poetry-core = [];});postPatch = (old.postPatch or "")+(''
                    substituteInPlace pyproject.toml --replace-fail "poetry.masonry.api" "poetry.core.masonry.api"
                '')+(''
                ${helpers.tomlreplace} pyproject.toml build-system.requires "[]"
        '');}
        
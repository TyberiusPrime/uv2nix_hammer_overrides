{final, helpers, resolveBuildSystem, ...}
        : old: if (helpers.isWheel old) then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {poetry-core = [];setuptools = [];});postPatch = (old.postPatch or "")+(''
                    substituteInPlace pyproject.toml --replace-fail "poetry.masonry.api" "poetry.core.masonry.api"
                '');}
        
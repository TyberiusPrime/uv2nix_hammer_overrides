{resolveBuildSystem, helpers, final, pkgs, ...}
        : old: if ((old.format or "sdist") == "wheel") then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ [pkgs.mpi] ++ ( resolveBuildSystem {build = [];cython = [];setuptools = [];});postPatch = (old.postPatch or "")+(''
                ${helpers.tomlreplace} pyproject.toml build-system.requires "[]"
        '');}
        
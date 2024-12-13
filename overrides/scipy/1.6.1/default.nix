{final, helpers, pkgs, resolveBuildSystem, ...}
        : old: if (helpers.isWheel old) then {buildInputs = old.buildInputs or [] ++ [pkgs.openblas pkgs.pkg-config];} else {buildInputs = old.buildInputs or [] ++ [pkgs.openblas pkgs.pkg-config];nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {"cython_0" = [];numpy = [];pybind11 = [];setuptools = [];wheel = [];});postPatch = (old.postPatch or "")+(''
                ${helpers.tomlreplace} pyproject.toml build-system.requires "[]"
        '');}
        
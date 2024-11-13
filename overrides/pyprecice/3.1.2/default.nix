{resolveBuildSystem, helpers, final, pkgs, ...}
        : old: if (helpers.isWheel old) then {buildInputs = old.buildInputs or [] ++ [pkgs.precice];} else {buildInputs = old.buildInputs or [] ++ [pkgs.precice];nativeBuildInputs = old.nativeBuildInputs or [] ++ [pkgs.pkg-config] ++ ( resolveBuildSystem {cython = [];mpi4py = [];numpy = [];packaging = [];pip = [];pkgconfig = [];setuptools = [];wheel = [];});postPatch = (old.postPatch or "")+(''
                ${helpers.tomlreplace} pyproject.toml build-system.requires "[]"
        '');}
        
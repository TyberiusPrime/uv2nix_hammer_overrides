{resolveBuildSystem, helpers, final, pkgs, ...}
        : old: if (helpers.isWheel old) then {buildInputs = old.buildInputs or [] ++ [pkgs.openjdk];preFixup = ''addAutoPatchelfSearchPath ${pkgs.openjdk}/lib/openjdk/lib/server/
'';} else {buildInputs = old.buildInputs or [] ++ [pkgs.openjdk];nativeBuildInputs = old.nativeBuildInputs or [] ++ [pkgs.openjdk] ++ ( resolveBuildSystem {"cython_0" = [];numpy = [];setuptools = [];});postPatch = (old.postPatch or "")+(''
                ${helpers.tomlreplace} pyproject.toml build-system.requires "[]"
        '');}
        
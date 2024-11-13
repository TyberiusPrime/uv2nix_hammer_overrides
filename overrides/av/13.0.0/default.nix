{resolveBuildSystem, helpers, final, pkgs, ...}
        : old: if (helpers.isWheel old) then {buildInputs = old.buildInputs or [] ++ [pkgs.ffmpeg];} else {buildInputs = old.buildInputs or [] ++ [pkgs.ffmpeg];nativeBuildInputs = old.nativeBuildInputs or [] ++ [pkgs.pkg-config] ++ ( resolveBuildSystem {cython = [];setuptools = [];});}
        
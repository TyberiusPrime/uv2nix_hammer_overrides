{resolveBuildSystem, helpers, final, pkgs, ...}
        : old: if (helpers.isWheel old) then {buildInputs = old.buildInputs or [] ++ [pkgs.glib];} else {buildInputs = old.buildInputs or [] ++ [pkgs.glib];nativeBuildInputs = old.nativeBuildInputs or [] ++ [pkgs.glib.dev pkgs.libjpeg pkgs.libpng pkgs.libtiff pkgs.pkg-config] ++ ( resolveBuildSystem {numpy = [];setuptools = [];});}
        
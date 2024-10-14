{resolveBuildSystem, final, pkgs, ...}
        : old: if ((old.format or "sdist") == "wheel") then {buildInputs = old.buildInputs or [] ++ [pkgs.glib];} else {buildInputs = old.buildInputs or [] ++ [pkgs.glib];nativeBuildInputs = old.nativeBuildInputs or [] ++ [pkgs.glib.dev pkgs.libjpeg pkgs.libpng pkgs.libtiff pkgs.pkg-config] ++ ( resolveBuildSystem {numpy = [];setuptools = [];});}
        
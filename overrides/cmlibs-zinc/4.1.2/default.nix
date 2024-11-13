{helpers, pkgs, ...}
        : old: {buildInputs = old.buildInputs or [] ++ [pkgs.freetype pkgs.libGLU pkgs.libxml2 pkgs.xz];}
        
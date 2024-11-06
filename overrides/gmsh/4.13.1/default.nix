{pkgs, ...}
        : old: {buildInputs = old.buildInputs or [] ++ [pkgs.fontconfig pkgs.libGLU pkgs.xorg.libXcursor pkgs.xorg.libXfixes pkgs.xorg.libXft pkgs.xorg.libXinerama];}
        
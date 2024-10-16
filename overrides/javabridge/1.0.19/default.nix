{resolveBuildSystem, final, pkgs, ...}
        : old: if ((old.format or "sdist") == "wheel") then {buildInputs = old.buildInputs or [] ++ [pkgs.openjdk];preFixup = ''addAutoPatchelfSearchPath ${pkgs.openjdk}/lib/openjdk/lib/server/
'';} else {buildInputs = old.buildInputs or [] ++ [pkgs.openjdk];nativeBuildInputs = old.nativeBuildInputs or [] ++ [pkgs.openjdk] ++ ( resolveBuildSystem {"cython_0" = [];numpy = [];setuptools = [];});}
        
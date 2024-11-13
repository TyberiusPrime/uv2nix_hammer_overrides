{helpers, pkgs, final, ...}
        : old: if (helpers.isWheel old) then {buildInputs = old.buildInputs or [] ++ [final.pyvex];preFixup = ''addAutoPatchelfSearchPath ${final.pyvex}/${final.python.sitePackages}/pyvex/lib
'';} else {buildInputs = old.buildInputs or [] ++ [final.pyvex];nativeBuildInputs = old.nativeBuildInputs or [] ++ [final.pyvex];}
        
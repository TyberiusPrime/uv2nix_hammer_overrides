{resolveBuildSystem, final, pkgs, ...}
        : old: if ((old.passthru.format or "sdist") == "wheel") then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ [pkgs.linuxHeaders] ++ ( resolveBuildSystem {setuptools = [];});postPatch = (old.postPatch or "")+(''
                if [ -e setup.py ]; then
                     substituteInPlace setup.py --replace-quiet /usr/include ${pkgs.linuxHeaders}/include
                fi
                '');}
        
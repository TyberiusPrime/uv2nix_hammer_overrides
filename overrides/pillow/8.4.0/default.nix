{final, helpers, pkgs, resolveBuildSystem, ...}
        : old: if (helpers.isWheel old) then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {setuptools = [];});preConfigure = [old.preConfigure or "" pkgs.python3Packages.pillow.preConfigure];}
        
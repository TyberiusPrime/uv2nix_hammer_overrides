{final, helpers, pkgs, resolveBuildSystem, ...}
        : old: if (helpers.isWheel old) then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ [(pkgs.boost.override {python = final.python; numpy=final.numpy; enablePython=true;}) pkgs.exiv2] ++ ( resolveBuildSystem {setuptools = [];});}
        
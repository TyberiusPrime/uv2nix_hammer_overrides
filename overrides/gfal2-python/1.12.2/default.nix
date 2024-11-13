{resolveBuildSystem, helpers, final, pkgs, ...}
        : old: if (helpers.isWheel old) then {} else {dontUseCmakeConfigure = true;nativeBuildInputs = old.nativeBuildInputs or [] ++ [(pkgs.boost.override {python = final.python; numpy=final.numpy; enablePython=true;}) pkgs.cmake pkgs.gfal2 pkgs.glib pkgs.pcre2 pkgs.pkg-config] ++ ( resolveBuildSystem {setuptools = [];});}
        
{pkgs, final, ...}
        : old: if ((old.passthru.format or "sdist") == "wheel") then {buildInputs = old.buildInputs or [] ++ [
             (pkgs.boost183.override {
                 python = final.python;
                 numpy = final.numpy;
                 enablePython = true;
             })
              final.eigenpy pkgs.assimp pkgs.boost183 pkgs.octomap pkgs.qhull];preFixup = ''addAutoPatchelfSearchPath ${final.eigenpy}/${final.python.sitePackages}/cmeel.prefix/${final.python.sitePackages}
'';} else {buildInputs = old.buildInputs or [] ++ [
             (pkgs.boost183.override {
                 python = final.python;
                 numpy = final.numpy;
                 enablePython = true;
             })
              final.eigenpy pkgs.assimp pkgs.boost183 pkgs.octomap pkgs.qhull];}
        
{resolveBuildSystem, helpers, final, pkgs, ...}
        : old: if (helpers.isWheel old) then {buildInputs = old.buildInputs or [] ++ [pkgs.systemd];} else {buildInputs = old.buildInputs or [] ++ [pkgs.systemd];nativeBuildInputs = old.nativeBuildInputs or [] ++ [pkgs.pkg-config] ++ ( resolveBuildSystem {setuptools = [];});}
        
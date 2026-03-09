{final, helpers, pkgs, ...}
        : old: if (helpers.isWheel old) then {autoPatchelfIgnoreMissingDeps = true;} else {"R_HOME" = "${pkgs.R}";env = {dontUsePyprojectBytecode = true;};}
        
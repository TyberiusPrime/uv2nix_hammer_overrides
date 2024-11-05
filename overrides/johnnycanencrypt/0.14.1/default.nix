{pkgs, ...}
        : old: {buildInputs = old.buildInputs or [] ++ [pkgs.pcsclite];}
        
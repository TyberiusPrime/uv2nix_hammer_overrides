{helpers, pkgs, ...}
        : old: {buildInputs = old.buildInputs or [] ++ [pkgs.SDL2];}
        
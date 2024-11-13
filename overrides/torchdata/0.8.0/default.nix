{helpers, pkgs, ...}
        : old: {buildInputs = old.buildInputs or [] ++ [pkgs.curl pkgs.openssl];}
        
{helpers, pkgs, ...}
        : old: {buildInputs = old.buildInputs or [] ++ [pkgs.cairo pkgs.fontconfig pkgs.freetype pkgs.gtk2 pkgs.gtk3 pkgs.openssl pkgs.pango pkgs.pkg-config];}
        
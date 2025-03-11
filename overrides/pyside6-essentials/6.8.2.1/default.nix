{helpers, pkgs, ...}
        : old: {buildInputs = old.buildInputs or [] ++ [pkgs.cairo pkgs.dbus pkgs.fontconfig pkgs.freetype pkgs.pango pkgs.unixODBC];dontWrapQtApps = true;}
        
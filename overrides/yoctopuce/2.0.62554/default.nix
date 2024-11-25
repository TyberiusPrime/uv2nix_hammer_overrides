{helpers, pkgs, ...}
        : old: {buildInputs = old.buildInputs or [] ++ [pkgs.libusb1];}
        
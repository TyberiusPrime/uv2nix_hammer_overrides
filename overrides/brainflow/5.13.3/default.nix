{helpers, pkgs, ...}
        : old: {buildInputs = old.buildInputs or [] ++ [pkgs.bluez pkgs.dbus pkgs.libusb1];}
        
{pkgs, ...}
        : old: if ((old.passthru.format or "sdist") == "wheel") then {buildInputs = old.buildInputs or [] ++ [pkgs.krb5];} else {buildInputs = old.buildInputs or [] ++ [pkgs.krb5];nativeBuildInputs = old.nativeBuildInputs or [] ++ [pkgs.krb5];}
        
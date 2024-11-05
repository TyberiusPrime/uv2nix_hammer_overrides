{pkgs, ...}
        : old: if ((old.format or "sdist") == "wheel") then {buildInputs = old.buildInputs or [] ++ [pkgs.gfortran13 pkgs.gfortran13.cc pkgs.gfortran13.out];} else {buildInputs = old.buildInputs or [] ++ [pkgs.gfortran13 pkgs.gfortran13.cc pkgs.gfortran13.out];nativeBuildInputs = old.nativeBuildInputs or [] ++ [pkgs.gfortran13.cc pkgs.gfortran13.cc.lib pkgs.gfortran13.out];}
        
{final, helpers, pkgs, resolveBuildSystem, ...}
        : old: if (helpers.isWheel old) then {buildInputs = old.buildInputs or [] ++ [pkgs.gfortran13.cc pkgs.gfortran13.out];} else {buildInputs = old.buildInputs or [] ++ [pkgs.gfortran13.cc pkgs.gfortran13.out];nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {setuptools = [];});}
        
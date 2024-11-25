{final, helpers, pkgs, resolveBuildSystem, ...}
        : old: if (helpers.isWheel old) then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ [pkgs.curl.dev] ++ ( resolveBuildSystem {pybind11 = [];setuptools = [];});}
        
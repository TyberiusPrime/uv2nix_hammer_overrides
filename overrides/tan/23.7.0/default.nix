{final, helpers, resolveBuildSystem, ...}
        : old: if (helpers.isWheel old) then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {hatch-fancy-pypi-readme = [];hatch-vcs = [];hatchling = [];});}
        
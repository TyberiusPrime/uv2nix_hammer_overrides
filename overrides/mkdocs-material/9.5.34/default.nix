{final, helpers, resolveBuildSystem, ...}
        : old: if (helpers.isWheel old) then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {hatch-nodejs-version = [];hatch-requirements-txt = [];hatchling = [];trove-classifiers = [];});}
        
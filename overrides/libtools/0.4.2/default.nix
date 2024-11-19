{final, helpers, resolveBuildSystem, ...}
        : old: if (helpers.isWheel old) then {} else {env = {HOME = "/tmp";};nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {pygments = [];setuptools = [];});}
        
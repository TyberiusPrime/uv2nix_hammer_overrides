{resolveBuildSystem, final, ...}
        : old: if ((old.passthru.format or "sdist") == "wheel") then {} else {env = {HOME = "/tmp";};nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {pygments = [];setuptools = [];});}
        
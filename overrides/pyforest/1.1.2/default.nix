{resolveBuildSystem, final, ...}
        : old: if ((old.format or "sdist") == "wheel") then {} else {env = {HOME = "/tmp";};nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {setuptools = [];});}
        
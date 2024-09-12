
        {final, helpers, ...}: old: if ((old.format or "sdist") == "wheel") then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ [final.pybind11 final.cmake final.setuptools final.wheel];postPatch = (old.postPatch or "")+''
                ${helpers.tomlreplace} pyproject.toml build-system.requires "[]"
        '';preBuild = ''
                cd /build
                cd ${old.pname}-${old.version}
                '';}
        
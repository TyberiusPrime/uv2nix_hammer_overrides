{final, helpers, pkgs, resolveBuildSystem, ...}
        : old: if (helpers.isWheel old) then {buildInputs = old.buildInputs or [] ++ [pkgs.cairo];} else {buildInputs = old.buildInputs or [] ++ [pkgs.cairo];nativeBuildInputs = old.nativeBuildInputs or [] ++ [pkgs.meson pkgs.pkg-config] ++ ( resolveBuildSystem {meson-python = [];ninja = [];});preBuild = [old.preBuild or "" ''
                cd /build
                # find the first directory containing either pyproject.toml or setup.py
                buildDir=$(find . -maxdepth 1 -type d -exec test -e "{}/pyproject.toml" -o -e "{}/setup.py" \; -print -quit)
                cd $buildDir
                ''];}
        
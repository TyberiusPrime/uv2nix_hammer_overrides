{ final, ... }: old: { nativeBuildInputs = old.nativeBuildInputs or [ ] ++ [ final.setuptools ]; }

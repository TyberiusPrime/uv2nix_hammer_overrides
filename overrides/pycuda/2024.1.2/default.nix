{final, helpers, pkgs, resolveBuildSystem, ...}
        : old: if (helpers.isWheel old) then {buildInputs = old.buildInputs or [] ++ [pkgs.cudaPackages.cuda_cudart];} else {buildInputs = old.buildInputs or [] ++ [pkgs.cudaPackages.cuda_cudart];nativeBuildInputs = old.nativeBuildInputs or [] ++ [pkgs.cudaPackages.cuda_cudart pkgs.cudaPackages.cuda_nvcc pkgs.cudaPackages.cuda_profiler_api pkgs.cudaPackages.libcurand] ++ ( resolveBuildSystem {numpy = [];setuptools = [];wheel = [];});postPatch = (old.postPatch or "")+(''
                ${helpers.tomlreplace} pyproject.toml build-system.requires "[]"
        '');}
        
{ helpers, final, ... }:
old:
if (old.format == "wheel") then
  { }
else
  {
    nativeBuildInputs = old.nativeBuildInputs or [ ] ++ [
      final.wheel
      final.setuptools
      final.cython_0
    ];
    patchPhase = ''
      ${helpers.tomlreplace} pyproject.toml build-system.requires "[]"
    '';
  }

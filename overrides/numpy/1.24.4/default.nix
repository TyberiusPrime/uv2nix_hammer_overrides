{ final, helpers, ... }:
old:
if ((old.format or "sdist") == "wheel") then
  { }
else
  {
    nativeBuildInputs = old.nativeBuildInputs or [ ] ++ [
      final.setuptools
      final.cython_0
      final.wheel
    ];
    patchPhase = ''
      ${helpers.tomlreplace} pyproject.toml build-system.requires "[]"
    '';
  }

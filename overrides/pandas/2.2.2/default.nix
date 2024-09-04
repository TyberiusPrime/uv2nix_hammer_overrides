{ final, helpers, ... }:
old:
if ((old.format or "sdist") == "wheel") then
  { }
else
  {
    nativeBuildInputs = old.nativeBuildInputs or [ ] ++ [
      final.meson
      final.wheel
      final.versioneer
      final.cython
      final.numpy
      final.meson-python
    ];
    patchPhase = ''
      ${helpers.tomlreplace} pyproject.toml build-system.requires "[]"
    '';
  }

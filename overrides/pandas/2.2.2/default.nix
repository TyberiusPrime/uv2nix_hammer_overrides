{ resolveBuildSystem, helpers, ... }:
old:
if ((old.passthru.format or "sdist") == "wheel") then
  { }
else
  {
    nativeBuildInputs =
      old.nativeBuildInputs or [ ]
      ++ (resolveBuildSystem {
        cython = [ ];
        meson = [ ];
        meson-python = [ ];
        numpy = [ ];
        versioneer = [ ];
        wheel = [ ];
      });
    postPatch =
      (old.postPatch or "")
      + ''
        ${helpers.tomlreplace} pyproject.toml build-system.requires "[]"
      '';
  }
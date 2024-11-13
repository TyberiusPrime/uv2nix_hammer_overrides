{ resolveBuildSystem, helpers, ... }:
old:
if (helpers.isWheel old) then
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
      + (''
        ${helpers.tomlreplace} pyproject.toml build-system.requires "[]"
      '');
  }

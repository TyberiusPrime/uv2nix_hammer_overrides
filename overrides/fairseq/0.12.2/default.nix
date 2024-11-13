{ resolveBuildSystem, helpers, ... }:
old:
if (helpers.isWheel old) then
  { }
else
  {
    nativeBuildInputs =
      old.nativeBuildInputs or [ ]
      ++ (resolveBuildSystem {
        "cython_0" = [ ];
        numpy = [ ];
        setuptools = [ ];
        wheel = [ ];
      });
    postPatch =
      (old.postPatch or "")
      + (''
        ${helpers.tomlreplace} pyproject.toml build-system.requires "[]"
      '');
  }

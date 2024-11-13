{ resolveBuildSystem, helpers, ... }:
old:
if (helpers.isWheel old) then
  { }
else
  {
    nativeBuildInputs =
      old.nativeBuildInputs or [ ]
      ++ (resolveBuildSystem {
        cppyy-backend = [ ];
        cppyy-cling = [ ];
        setuptools = [ ];
        wheel = [ ];
      });
    postPatch =
      (old.postPatch or "")
      + (''
        ${helpers.tomlreplace} pyproject.toml build-system.requires "[]"
      '');
  }

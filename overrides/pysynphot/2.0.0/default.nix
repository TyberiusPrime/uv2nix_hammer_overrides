{ resolveBuildSystem, helpers, ... }:
old:
if (helpers.isWheel old) then
  { }
else
  {
    nativeBuildInputs =
      old.nativeBuildInputs or [ ]
      ++ (resolveBuildSystem {
        numpy = [ ];
        setuptools = [ ];
        setuptools-scm = [ ];
        wheel = [ ];
      });
    postPatch =
      (old.postPatch or "")
      + (''
        ${helpers.tomlreplace} pyproject.toml build-system.requires "[]"
      '');
  }

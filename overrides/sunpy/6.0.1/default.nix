{ helpers, resolveBuildSystem, ... }:
old:
if (helpers.isWheel old) then
  { }
else
  {
    nativeBuildInputs =
      old.nativeBuildInputs or [ ]
      ++ (resolveBuildSystem {
        extension-helpers = [ ];
        numpy = [ ];
        setuptools = [ ];
        setuptools-scm = [ ];
        wheel = [ ];
      });
  }

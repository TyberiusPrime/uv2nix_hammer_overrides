{ helpers, resolveBuildSystem, ... }:
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
  }

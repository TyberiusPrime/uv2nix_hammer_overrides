{ helpers, resolveBuildSystem, ... }:
old:
if (helpers.isWheel old) then
  { }
else
  {
    nativeBuildInputs =
      old.nativeBuildInputs or [ ]
      ++ (resolveBuildSystem {
        absl-py = [ ];
        mujoco = [ ];
        pyparsing = [ ];
        setuptools = [ ];
        wheel = [ ];
      });
  }

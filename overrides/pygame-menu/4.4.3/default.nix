{ helpers, resolveBuildSystem, ... }:
old:
if (helpers.isWheel old) then
  { }
else
  {
    nativeBuildInputs =
      old.nativeBuildInputs or [ ]
      ++ (resolveBuildSystem {
        poetry-core = [ ];
        setuptools = [ ];
        wheel = [ ];
      });
    postPatch =
      (old.postPatch or "")
      + ''
        substituteInPlace pyproject.toml --replace-fail "poetry.masonry.api" "poetry.core.masonry.api"
      '';
  }

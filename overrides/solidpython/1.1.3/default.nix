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
        pytest-runner = [ ];
        setuptools = [ ];
        setuptools-scm = [ ];
        wheel = [ ];
      });
    postPatch =
      (old.postPatch or "")
      + ''
        substituteInPlace pyproject.toml --replace-fail "poetry.masonry.api" "poetry.core.masonry.api"
      '';
  }

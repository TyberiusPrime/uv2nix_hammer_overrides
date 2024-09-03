{ final, helpers, ... }:
old: {
  nativeBuildInputs = old.nativeBuildInputs or [ ] ++ [
    final.wheel
    final.cython_0
    final.setuptools
  ];
  patchPhase = ''
    ${helpers.tomlreplace} pyproject.toml build-system.requires "[]"
  '';
}

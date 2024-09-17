{
  helpers,
  final,
  pkgs,
  ...
}:
old:
if ((old.format or "sdist") == "wheel") then
  { buildInputs = old.buildInputs or [ ] ++ [ pkgs.openjdk ]; }
else
  {
    buildInputs = old.buildInputs or [ ] ++ [ pkgs.openjdk ];
    nativeBuildInputs =
      old.nativeBuildInputs or [ ]
      ++ [ pkgs.openjdk ]
      ++ [
        final.cython_0
        final.setuptools
        final.numpy
      ];
    postPatch =
      (old.postPatch or "")
      + ''
        ${helpers.tomlreplace} pyproject.toml build-system.requires "[]"
      '';
  }

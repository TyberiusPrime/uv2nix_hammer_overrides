{
  resolveBuildSystem,
  helpers,
  pkgs,
  ...
}:
old:
if ((old.passthru.format or "sdist") == "wheel") then
  { buildInputs = old.buildInputs or [ ] ++ [ pkgs.openjdk ]; }
else
  {
    buildInputs = old.buildInputs or [ ] ++ [ pkgs.openjdk ];
    nativeBuildInputs =
      old.nativeBuildInputs or [ ]
      ++ [ pkgs.openjdk ]
      ++ (resolveBuildSystem {
        "cython_0" = [ ];
        numpy = [ ];
        setuptools = [ ];
      });
    postPatch =
      (old.postPatch or "")
      + ''
        ${helpers.tomlreplace} pyproject.toml build-system.requires "[]"
      '';
  }
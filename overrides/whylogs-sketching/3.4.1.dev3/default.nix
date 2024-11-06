{ resolveBuildSystem, helpers, ... }:
old:
if ((old.passthru.format or "sdist") == "wheel") then
  { }
else
  {
    nativeBuildInputs =
      old.nativeBuildInputs or [ ]
      ++ (resolveBuildSystem {
        cmake = [ ];
        pybind11 = [ ];
        setuptools = [ ];
        wheel = [ ];
      });
    postPatch =
      (old.postPatch or "")
      + ''
        ${helpers.tomlreplace} pyproject.toml build-system.requires "[]"
      '';
    preBuild = [
      old.preBuild or ""
      ''
        cd /build
        cd ${old.pname}-${old.version}
      ''
    ];
  }
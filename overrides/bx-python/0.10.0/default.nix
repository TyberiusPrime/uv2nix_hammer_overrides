{ resolveBuildSystem, pkgs, ... }:
old:
if ((old.passthru.format or "sdist") == "wheel") then
  { buildInputs = old.buildInputs or [ ] ++ [ pkgs.zlib.out ]; }
else
  {
    buildInputs = old.buildInputs or [ ] ++ [ pkgs.zlib.out ];
    nativeBuildInputs =
      old.nativeBuildInputs or [ ]
      ++ [
        pkgs.pkg-config
        pkgs.zlib.dev
      ]
      ++ (resolveBuildSystem {
        cython = [ ];
        oldest-supported-numpy = [ ];
        setuptools = [ ];
        wheel = [ ];
      });
  }

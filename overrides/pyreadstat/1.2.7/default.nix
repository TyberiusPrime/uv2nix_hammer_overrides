{
  helpers,
  pkgs,
  resolveBuildSystem,
  ...
}:
old:
if (helpers.isWheel old) then
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
        setuptools = [ ];
        wheel = [ ];
      });
  }

{
  helpers,
  pkgs,
  resolveBuildSystem,
  ...
}:
old:
if (helpers.isWheel old) then
  { buildInputs = old.buildInputs or [ ] ++ [ pkgs.zlib ]; }
else
  {
    buildInputs = old.buildInputs or [ ] ++ [ pkgs.zlib ];
    nativeBuildInputs =
      old.nativeBuildInputs or [ ]
      ++ (resolveBuildSystem {
        cython = [ ];
        setuptools = [ ];
        wheel = [ ];
      });
  }

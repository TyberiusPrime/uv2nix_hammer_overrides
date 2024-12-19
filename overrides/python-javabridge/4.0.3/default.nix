{
  helpers,
  pkgs,
  resolveBuildSystem,
  ...
}:
old:
if (helpers.isWheel old) then
  {
    buildInputs = old.buildInputs or [ ] ++ [ pkgs.openjdk ];
    preFixup = ''
      addAutoPatchelfSearchPath ${pkgs.openjdk}/lib/openjdk/lib/server/
    '';
  }
else
  {
    buildInputs = old.buildInputs or [ ] ++ [ pkgs.openjdk ];
    nativeBuildInputs =
      old.nativeBuildInputs or [ ]
      ++ [ pkgs.openjdk ]
      ++ (resolveBuildSystem {
        numpy = [ ];
        setuptools = [ ];
      });
  }

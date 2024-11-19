{
  helpers,
  pkgs,
  resolveBuildSystem,
  ...
}:
old:
if (helpers.isWheel old) then
  { buildInputs = old.buildInputs or [ ] ++ [ pkgs.portaudio ]; }
else
  {
    buildInputs = old.buildInputs or [ ] ++ [ pkgs.portaudio ];
    nativeBuildInputs =
      old.nativeBuildInputs or [ ]
      ++ (resolveBuildSystem {
        setuptools = [ ];
        wheel = [ ];
      });
  }

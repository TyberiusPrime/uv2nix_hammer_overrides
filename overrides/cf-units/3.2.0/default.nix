{
  resolveBuildSystem,
  helpers,
  pkgs,
  ...
}:
old:
if (helpers.isWheel old) then
  { buildInputs = old.buildInputs or [ ] ++ [ pkgs.udunits ]; }
else
  {
    buildInputs = old.buildInputs or [ ] ++ [ pkgs.udunits ];
    env = {
      "UDUNITS2_XML_PATH" = "${pkgs.udunits}/share/udunits/udunits2.xml";
    };
    nativeBuildInputs =
      old.nativeBuildInputs or [ ]
      ++ (resolveBuildSystem {
        "cython_0" = [ ];
        oldest-supported-numpy = [ ];
        setuptools = [ ];
        setuptools-scm = [ ];
        wheel = [ ];
      });
  }

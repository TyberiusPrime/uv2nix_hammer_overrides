{
  final,
  helpers,
  pkgs,
  resolveBuildSystem,
  ...
}:
old:
if (helpers.isWheel old) then
  { }
else
  {
    env = {
      "TA_INCLUDE_PATH" = "${pkgs.ta-lib}/include";
      "TA_LIBRARY_PATH" = "${pkgs.ta-lib}/lib";
    };
    nativeBuildInputs =
      old.nativeBuildInputs or [ ]
      ++ [
        final.cython_0
        pkgs.ta-lib
      ]
      ++ (resolveBuildSystem {
        numpy = [ ];
        setuptools = [ ];
        wheel = [ ];
      });
  }

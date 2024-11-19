{
  helpers,
  pkgs,
  resolveBuildSystem,
  ...
}:
old:
let
  funcs = [
    (
      old:
      old
      // (
        if (helpers.isWheel old) then
          { }
        else
          {
            nativeBuildInputs =
              old.nativeBuildInputs or [ ]
              ++ (resolveBuildSystem {
                setuptools = [ ];
                setuptools-rust = [ ];
                wheel = [ ];
              });
          }
      )
    )
    (
      old:
      old
      // (pkgs.lib.optionalAttrs (!helpers.isWheel old) (
        helpers.standardMaturin {
          furtherArgs = {
            postPatch = ''
              cp ${./Cargo.lock} Cargo.lock
            '';
          };
        } old
      ))
    )
  ];
in
pkgs.lib.trivial.pipe old funcs

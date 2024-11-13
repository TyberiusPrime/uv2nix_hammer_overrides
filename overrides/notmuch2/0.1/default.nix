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
          { buildInputs = old.buildInputs or [ ] ++ [ pkgs.notmuch ]; }
        else
          {
            buildInputs = old.buildInputs or [ ] ++ [ pkgs.notmuch ];
            nativeBuildInputs =
              old.nativeBuildInputs or [ ]
              ++ (resolveBuildSystem {
                cffi = [ ];
                setuptools = [ ];
              });
          }
      )
    )
    (
      old:
      old
      // ({
        postPatch = ''
          substituteInPlace notmuch2/_build.py \
            --replace-fail "include_dirs=['../../lib']," "include_dirs=['${pkgs.notmuch}/include'],"
        '';
      })
    )
  ];
in
pkgs.lib.trivial.pipe old funcs

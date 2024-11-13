{
  helpers,
  resolveBuildSystem,
  pkgs,
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
          { nativeBuildInputs = old.nativeBuildInputs or [ ] ++ (resolveBuildSystem { setuptools = [ ]; }); }
      )
    )
    (old: old // ({ buildInputs = [ pkgs.ssdeep ]; }))
  ];
in
pkgs.lib.trivial.pipe old funcs

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
          { nativeBuildInputs = old.nativeBuildInputs or [ ] ++ (resolveBuildSystem { pdm-backend = [ ]; }); }
      )
    )
    (
      old:
      old
      // {
        meta.priority = 1; # to prevent collision with fastapi default bin/fastapi
      }
    )
  ];
in
pkgs.lib.trivial.pipe old funcs

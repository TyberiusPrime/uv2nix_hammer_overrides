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
              ++ (resolveBuildSystem { setuptools = [ ]; });
          }
      )
    )
    (
      old:
      old
      // {
        postPatch = ''
          # replace bundled bwa
          rm -r bwa/*
          cp ${pkgs.bwa}/lib/*.a ${pkgs.bwa}/include/*.h bwa/

          substituteInPlace setup.py \
            --replace-quiet 'setuptools>=49.2.0' 'setuptools'
        '';

        buildInputs = old.buildInputs or [ ] ++ [
          pkgs.zlib
          pkgs.bwa
        ];
      }
    )
  ];
in
pkgs.lib.trivial.pipe old funcs

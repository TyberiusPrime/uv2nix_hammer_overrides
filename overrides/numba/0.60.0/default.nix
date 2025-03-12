{
  final,
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
          { buildInputs = old.buildInputs or [ ] ++ [ pkgs.tbb_2021_11.out ]; }
        else
          {
            buildInputs = old.buildInputs or [ ] ++ [ pkgs.tbb_2021_11.out ];
            nativeBuildInputs =
              old.nativeBuildInputs or [ ]
              ++ (resolveBuildSystem {
                numpy = [ ];
                setuptools = [ ];
              });
          }
      )
    )
    (
      old:
      old
      // {
        # we want tbb to be available, since it's the only one that does
        # thread & fork safety.
        postInstall = ''
          pushd .
          cd $out
          substituteInPlace ${final.python.sitePackages}/numba/np/ufunc/parallel.py --replace 'libtbb.so.12' '${pkgs.tbb_2021_11}/lib/libtbb.so.12'
          popd
        '';
      }
    )
  ];
in
pkgs.lib.trivial.pipe old funcs

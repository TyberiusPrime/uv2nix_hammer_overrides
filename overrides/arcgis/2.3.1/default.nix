{
  resolveBuildSystem,
  final,
  pkgs,
  ...
}
: old: let
  funcs = [
    (old:
      old
      // (
        if ((old.format or "sdist") == "wheel")
        then {}
        else {nativeBuildInputs = old.nativeBuildInputs or [] ++ (resolveBuildSystem {setuptools = [];});}
      ))
    (old:
      old
      // {
        postPatch = pkgs.lib.optionalString (old.format or "sdist" == "sdist") ''
          substituteInPlace setup.py --replace-warn "conda_install_mode = False" "conda_install_mode = True"
        '';
      })
  ];
in
  pkgs.lib.trivial.pipe old funcs

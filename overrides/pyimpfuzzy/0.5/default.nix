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
        buildInputs = [pkgs.ssdeep];
      })
  ];
in
  pkgs.lib.trivial.pipe old funcs

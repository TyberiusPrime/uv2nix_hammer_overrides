{final, helpers, pkgs, resolveBuildSystem, ...}
        :
            old:
            let funcs = [(old: old // ( if (helpers.isWheel old) then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {cmake = [];cython = [];ninja = [];numpy = [];scikit-build = [];setuptools = [];});})) (old: old // ( {
  postInstall =
    (old.postInstall or "")
    + (pkgs.lib.optionalString (helpers.isWheel old) ''
      echo idk
    '');
}
))];
            in
            pkgs.lib.trivial.pipe old funcs
    
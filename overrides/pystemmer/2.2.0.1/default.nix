{final, helpers, pkgs, resolveBuildSystem, ...}
        :
            old:
            let funcs = [(old: old // ( if (helpers.isWheel old) then {buildInputs = old.buildInputs or [] ++ [pkgs.libstemmer];} else {buildInputs = old.buildInputs or [] ++ [pkgs.libstemmer];nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {setuptools = [];});})) (old: old // ( {
  nativeBuildInputs = old.nativeBuildInputs ++ [pkgs.libstemmer final.cython];
  PYSTEMMER_SYSTEM_LIBSTEMMER = "${pkgs.libstemmer}";
}
))];
            in
            pkgs.lib.trivial.pipe old funcs
    
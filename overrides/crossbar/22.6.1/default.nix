{final, helpers, pkgs, resolveBuildSystem, ...}
        :
            old:
            let funcs = [(old: old // ( if (helpers.isWheel old) then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {setuptools = [];});})) (old: old // ( {
  postInstall =
    old.postInstall or ""
    + ''
      rm $out/LICENSE
    '';
}
))];
            in
            pkgs.lib.trivial.pipe old funcs
    
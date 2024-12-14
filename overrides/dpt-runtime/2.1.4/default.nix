{final, helpers, pkgs, resolveBuildSystem, ...}
        :
            old:
            let funcs = [(old: old // ( if (helpers.isWheel old) then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {setuptools = [];wheel = [];});})) (old: old // ( {
  postInstall =
    old.postInstall or ""
    + ''
      rm $out/docs/* -r
    '';
}
))];
            in
            pkgs.lib.trivial.pipe old funcs
    
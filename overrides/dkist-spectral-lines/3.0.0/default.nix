{final, helpers, pkgs, resolveBuildSystem, ...}
        :
            old:
            let funcs = [(old: old // ( if (helpers.isWheel old) then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {setuptools = [];setuptools-scm = [];});})) (old: old // ( {
  postInstall =
    old.postInstall or ""
    + ''
      rm -rf $out/${final.python.sitePackages}/licenses
      rm -rf $out/${final.python.sitePackages}/docs
    '';
}
))];
            in
            pkgs.lib.trivial.pipe old funcs
    
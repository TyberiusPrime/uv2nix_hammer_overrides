{resolveBuildSystem, final, pkgs, ...}
        :
            old:
            let funcs = [(old: old // ( if ((old.passthru.format or "sdist") == "wheel") then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {setuptools = [];});})) (old: old // ( {
  postInstall =
    old.postInstall
    or ""
    + ''
      rm -rf $out/${final.python.sitePackages}/tests
    '';
}
))];
            in
            pkgs.lib.trivial.pipe old funcs
    
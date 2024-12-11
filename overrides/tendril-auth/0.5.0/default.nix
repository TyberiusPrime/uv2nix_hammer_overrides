{final, helpers, pkgs, resolveBuildSystem, ...}
        :
            old:
            let funcs = [(old: old // ( if (helpers.isWheel old) then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {setuptools = [];});})) (old: old // ( {
  # remove final empty new line from __init__.py
  postInstall = ''
    sed -i '$d' $out/${final.python.sitePackages}/tendril/__init__.py
  '';
}
))];
            in
            pkgs.lib.trivial.pipe old funcs
    
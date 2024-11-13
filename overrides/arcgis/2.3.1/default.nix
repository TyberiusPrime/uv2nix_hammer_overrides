{resolveBuildSystem, helpers, final, pkgs, ...}
        :
            old:
            let funcs = [(old: old // ( if (helpers.isWheel old) then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {setuptools = [];});})) (old: old // ( {
  postPatch = pkgs.lib.optionalString (!helpers.isWheel old) ''
    substituteInPlace setup.py --replace-warn "conda_install_mode = False" "conda_install_mode = True"
  '';
}
))];
            in
            pkgs.lib.trivial.pipe old funcs
    
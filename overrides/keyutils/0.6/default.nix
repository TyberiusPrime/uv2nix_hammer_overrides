{final, helpers, pkgs, resolveBuildSystem, ...}
        :
            old:
            let funcs = [(old: old // ( if (helpers.isWheel old) then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {pytest-runner = [];setuptools = [];});})) (old: old // ( {
  # from nixpkgs 
  postPatch = ''
    substituteInPlace setup.py --replace '"pytest-runner"' ""
  '';

  preBuild = ''
    ${final.cython_0}/bin/cython keyutils/_keyutils.pyx
  '';

  preCheck = ''
    rm -rf keyutils
  '';

  buildInputs = [ pkgs.keyutils ];
}
))];
            in
            pkgs.lib.trivial.pipe old funcs
    
{final, pkgs, ...}
        :
            old:
            let funcs = [(old: old // ( if ((old.format or "sdist") == "wheel") then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ [final.pytest-runner final.setuptools];})) (old: old // {
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
})];
            in
            pkgs.lib.trivial.pipe old funcs
    
{final, pkgs, ...}
        :
            old:
            let funcs = [(old: old // ( {buildInputs = old.buildInputs or [] ++ [pkgs.tbb_2021_11.out];})) (old: old // ( {
  postInstall = ''
    pushd .
    cd $out
    substituteInPlace ${final.python.sitePackages}/numba/np/ufunc/parallel.py --replace 'libtbb.so.12' '${pkgs.tbb_2021_11}/lib/libtbb.so.12'
    popd
  '';
}
))];
            in
            pkgs.lib.trivial.pipe old funcs
    
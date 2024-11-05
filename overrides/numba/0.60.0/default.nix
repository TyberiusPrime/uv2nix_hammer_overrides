{final, pkgs, ...}
        :
            old:
            let funcs = [(old: old // ( {buildInputs = old.buildInputs or [] ++ [pkgs.tbb_2021_11.out];})) (old: old // ( {
<<<<<<< HEAD
  # we want tbb to be available, since it's the only one that does
  # thread & fork safety.
=======
>>>>>>> d98e7f2e6a7fb2349d4572fe463b8b85bb9b9d87
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
    
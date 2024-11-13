{final, pkgs, ...}
        : old: {
  # we want tbb to be available, since it's the only one that does
  # thread & fork safety.
  postInstall = ''
    pushd .
    cd $out
    substituteInPlace ${final.python.sitePackages}/numba/np/ufunc/parallel.py --replace 'libtbb.so.12' '${pkgs.tbb_2021_11}/lib/libtbb.so.12'
    popd
  '';
}

        
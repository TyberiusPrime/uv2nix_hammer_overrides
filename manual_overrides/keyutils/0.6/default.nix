{
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


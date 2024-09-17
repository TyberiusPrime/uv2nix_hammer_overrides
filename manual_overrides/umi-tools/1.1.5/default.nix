{
  preBuild = pkgs.lib.optionals (final.python.pythonAtLeast "3.12") ''
    ${final.cython}/bin/cython umi_tools/_dedup_umi.pyx
  '';
  buildInputs = old.buildInputs or [] ++ [final.pysam];
}

{
  postPatch = ''
    # replace bundled bwa
    rm -r bwa/*
    cp ${pkgs.bwa}/lib/*.a ${pkgs.bwa}/include/*.h bwa/

    substituteInPlace setup.py \
      --replace-quiet 'setuptools>=49.2.0' 'setuptools'
  '';

  buildInputs =
    old.buildInputs
    or []
    ++ [
      pkgs.zlib
      pkgs.bwa
    ];
}

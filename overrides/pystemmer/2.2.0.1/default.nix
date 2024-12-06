{final, pkgs, ...}
        : old: {
  nativeBuildInputs = old.nativeBuildInputs ++ [
    pkgs.libstemmer
    final.cython
  ];
  PYSTEMMER_SYSTEM_LIBSTEMMER = "${pkgs.libstemmer}";
}

        
{
  postPatch = ''
    substituteInPlace notmuch2/_build.py \
      --replace-fail "include_dirs=['../../lib']," "include_dirs=['${pkgs.notmuch}/include'],"
  '';
}

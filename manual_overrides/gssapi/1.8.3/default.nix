{
  #from nixpkgs
  postPatch = ''
    substituteInPlace setup.py \
      --replace 'get_output(f"{kc} gssapi --prefix")' '"${pkgs.lib.getDev pkgs.krb5}"'
  '';

  preCheck = ''
    mv gssapi/tests $TMPDIR/
    pushd $TMPDIR
  '';

  postCheck = ''
    popd
  '';
}

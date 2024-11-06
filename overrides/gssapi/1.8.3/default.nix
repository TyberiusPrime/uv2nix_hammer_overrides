{resolveBuildSystem, final, pkgs, ...}
        :
            old:
            let funcs = [(old: old // ( if ((old.passthru.format or "sdist") == "wheel") then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ [pkgs.krb5] ++ ( resolveBuildSystem {cython = [];setuptools = [];});})) (old: old // ( {
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
))];
            in
            pkgs.lib.trivial.pipe old funcs
    
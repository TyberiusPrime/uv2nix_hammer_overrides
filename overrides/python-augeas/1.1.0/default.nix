{final, helpers, pkgs, resolveBuildSystem, ...}
        :
            old:
            let funcs = [(old: old // ( if (helpers.isWheel old) then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {setuptools = [];});})) (old: old // ( {
  postPatch =
    let
      libname = "libaugeas${pkgs.stdenv.hostPlatform.extensions.sharedLibrary}";
    in
    old.postPatch or ""
    + ''
      substituteInPlace augeas/ffi.py \
      --replace-fail 'ffi.dlopen("augeas")' \
                'ffi.dlopen("${pkgs.lib.makeLibraryPath [ pkgs.augeas ]}/${libname}")'
    '';
}
))];
            in
            pkgs.lib.trivial.pipe old funcs
    
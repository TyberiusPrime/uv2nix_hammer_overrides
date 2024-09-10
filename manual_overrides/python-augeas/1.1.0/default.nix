{
  postPatch = let
    libname = "libaugeas${pkgs.stdenv.hostPlatform.extensions.sharedLibrary}";
  in old.postPatch or "" + ''
    substituteInPlace augeas/ffi.py \
    --replace-fail 'ffi.dlopen("augeas")' \
              'ffi.dlopen("${pkgs.lib.makeLibraryPath [pkgs.augeas]}/${libname}")'
  '';
}

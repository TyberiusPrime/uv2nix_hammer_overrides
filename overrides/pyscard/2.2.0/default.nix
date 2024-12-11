{final, helpers, pkgs, resolveBuildSystem, ...}
        :
            old:
            let funcs = [(old: old // ( if (helpers.isWheel old) then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {setuptools = [];swig = [];});})) (old: old // ( let
  # Package does not support configuring the pcsc library.
  withApplePCSC = pkgs.stdenv.isDarwin;
in
{
  nativeBuildInputs =
    old.nativeBuildInputs or [ ]
    ++ pkgs.lib.optionals (!withApplePCSC) [ pkgs.pkg-config ];

  buildInputs = if withApplePCSC then [ pkgs.PCSC ] else [ pkgs.pcsclite ];

  postPatch =
    if withApplePCSC then
      ''
        substituteInPlace src/smartcard/scard/winscarddll.c \
          --replace-fail "/System/Library/Frameworks/PCSC.framework/PCSC" \
                    "${pkgs.PCSC}/Library/Frameworks/PCSC.framework/PCSC"
      ''
    else
      ''
        substituteInPlace setup.py --replace-warn "pkg-config" "$PKG_CONFIG"
        substituteInPlace src/smartcard/scard/winscarddll.c \
          --replace-fail "libpcsclite.so.1" \
                    "${pkgs.lib.getLib pkgs.pcsclite}/lib/libpcsclite${pkgs.stdenv.hostPlatform.extensions.sharedLibrary}"
      '';

  preCheck = ''
    # remove src module, so tests use the installed module instead
    rm -r smartcard
  '';

  disabledTests = [
    # AssertionError
    "test_hresult"
    "test_low_level"
  ];
}
))];
            in
            pkgs.lib.trivial.pipe old funcs
    
{
  final,
  helpers,
  pkgs,
  resolveBuildSystem,
  ...
}:
old:
let
  funcs = [
    (
      old:
      old
      // (
        if (helpers.isWheel old) then
          { }
        else
          { nativeBuildInputs = old.nativeBuildInputs or [ ] ++ (resolveBuildSystem { setuptools = [ ]; }); }
      )
    )
    (
      old:
      old
      // (
        let
          inherit (pkgs) liberasurecode;
          inherit (pkgs) stdenv;
          inherit (pkgs) lib;
        in
        {
          buildInputs = [
            pkgs.liberasurecode
            final.setuptools
          ];
          nativeBuildInputs = old.nativeBuildInputs or [ ] ++ [ pkgs.liberasurecode.dev ];
          # from nixpkgs
          postPatch = ''
            # patch dlopen call
            substituteInPlace src/c/pyeclib_c/pyeclib_c.c \
              --replace "liberasurecode.so" "${liberasurecode}/lib/liberasurecode.so"
            # python's platform.platform() doesn't return "Darwin" (anymore?)
            substituteInPlace setup.py \
              --replace '"Darwin"' '"macOS"'
          '';
          preBuild =
            let
              ldLibraryPathEnvName = if stdenv.isDarwin then "DYLD_LIBRARY_PATH" else "LD_LIBRARY_PATH";
            in
            ''
              # required for the custom _find_library function in setup.py
              export ${ldLibraryPathEnvName}="${lib.makeLibraryPath [ liberasurecode ]}"
            '';
        }
      )
    )
  ];
in
pkgs.lib.trivial.pipe old funcs

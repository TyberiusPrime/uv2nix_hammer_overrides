{
  pkgs,
  final,
  ...
}
: old: let
  lib = pkgs.lib;
  stdenv = pkgs.stdenv;
  # see https://github.com/numba/llvmlite#compatibility
  llvm_version = toString (
    if lib.versionAtLeast old.version "0.40.0"
    then 14
    else if lib.versionAtLeast old.version "0.37.0"
    then 11
    else if lib.versionAtLeast old.version "0.34.0" && !stdenv.buildPlatform.isAarch64
    then 10
    else if lib.versionAtLeast old.version "0.33.0"
    then 9
    else if lib.versionAtLeast old.version "0.29.0"
    then 8
    else if lib.versionAtLeast old.version "0.27.0"
    then 7
    else if lib.versionAtLeast old.version "0.23.0"
    then 6
    else if lib.versionAtLeast old.version "0.21.0"
    then 5
    else 4
  );
  llvm = pkgs."llvmPackages_${llvm_version}".llvm or (throw "LLVM${llvm_version} has been removed from nixpkgs; upgrade llvmlite or use older nixpkgs");
in
  lib.optionalAttrs (!(old.src.isWheel or false)) {
    inherit llvm;
    nativeBuildInputs = old.nativeBuildInputs or [] ++ [final.llvmlite.llvm];

    # Static linking
    # https://github.com/numba/llvmlite/issues/93
    # was disabled by default in
    # https://github.com/numba/llvmlite/pull/250

    # Set directory containing llvm-config binary
    preConfigure = ''
      export LLVM_CONFIG=${llvm.dev}/bin/llvm-config
    '';

    __impureHostDeps = lib.optionals pkgs.stdenv.isDarwin ["/usr/lib/libm.dylib"];

    passthru = old.passthru // {inherit llvm;};
  }

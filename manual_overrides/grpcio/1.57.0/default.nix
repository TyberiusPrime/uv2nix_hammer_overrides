{
  nativeBuildInputs = old.nativeBuildInputs or [ ] ++ [ pkgs.pkg-config ];
  buildInputs = old.buildInputs or [ ] ++ [
    pkgs.c-ares
    pkgs.openssl
    pkgs.zlib
    final.cython_0
  ];

  outputs = [
    "out"
    "dev"
  ];

  GRPC_BUILD_WITH_BORING_SSL_ASM = "";
  GRPC_PYTHON_BUILD_SYSTEM_OPENSSL = 1;
  GRPC_PYTHON_BUILD_SYSTEM_ZLIB = 1;
  GRPC_PYTHON_BUILD_SYSTEM_CARES = 1;
  GRPC_PYTHON_BUILD_WITH_CYTHON = 1;
  DISABLE_LIBC_COMPATIBILITY = 1;
}

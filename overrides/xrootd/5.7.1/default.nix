{
  helpers,
  pkgs,
  resolveBuildSystem,
  ...
}:
old:
if (helpers.isWheel old) then
  { buildInputs = old.buildInputs or [ ] ++ [ pkgs.openssl ]; }
else
  {
    buildInputs = old.buildInputs or [ ] ++ [ pkgs.openssl ];
    dontUseCmakeConfigure = true;
    nativeBuildInputs =
      old.nativeBuildInputs or [ ]
      ++ [
        pkgs.cmake
        pkgs.libuuid
        pkgs.libxcrypt
        pkgs.pkg-config
        pkgs.zlib.dev
      ]
      ++ (resolveBuildSystem { setuptools = [ ]; });
  }

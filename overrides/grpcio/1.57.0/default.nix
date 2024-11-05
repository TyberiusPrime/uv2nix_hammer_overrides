<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
{resolveBuildSystem, final, pkgs, ...}
        :
            old:
            let funcs = [(old: old // ( if ((old.format or "sdist") == "wheel") then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {setuptools = [];});})) (old: old // ( {
=======
{final, pkgs, ...}
        : old: {
>>>>>>> 47ecffda093885d49866a2ab4dd85be06d1a3347
=======
{final, pkgs, ...}
        : old: {
>>>>>>> 5b858e988483041a6d696911c3a6011559872e9e
=======
{final, pkgs, ...}
        : old: {
>>>>>>> 01053e2ed30446105e78e3c6a6d86dd129e42b2e
=======
{final, pkgs, ...}
        : old: {
>>>>>>> c0969091896fdd3c5459e332658c3b9de30953a5
=======
{final, pkgs, ...}
        : old: {
>>>>>>> b773ac0803f9f9345ddd5254e856989c44d2ebe9
  nativeBuildInputs = old.nativeBuildInputs or [] ++ [pkgs.pkg-config];
  buildInputs = old.buildInputs or [] ++ [pkgs.c-ares pkgs.openssl pkgs.zlib final.cython_0];

  outputs = ["out" "dev"];

  GRPC_BUILD_WITH_BORING_SSL_ASM = "";
  GRPC_PYTHON_BUILD_SYSTEM_OPENSSL = 1;
  GRPC_PYTHON_BUILD_SYSTEM_ZLIB = 1;
  GRPC_PYTHON_BUILD_SYSTEM_CARES = 1;
  GRPC_PYTHON_BUILD_WITH_CYTHON = 1;
  DISABLE_LIBC_COMPATIBILITY = 1;
}
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
))];
            in
            pkgs.lib.trivial.pipe old funcs
    
=======

        
>>>>>>> 47ecffda093885d49866a2ab4dd85be06d1a3347
=======

        
>>>>>>> 5b858e988483041a6d696911c3a6011559872e9e
=======

        
>>>>>>> 01053e2ed30446105e78e3c6a6d86dd129e42b2e
=======

        
>>>>>>> c0969091896fdd3c5459e332658c3b9de30953a5
=======

        
>>>>>>> b773ac0803f9f9345ddd5254e856989c44d2ebe9

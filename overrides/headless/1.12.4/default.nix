<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
{final, pkgs, ...}
        : old: {
=======
{resolveBuildSystem, final, pkgs, ...}
        :
            old:
            let funcs = [(old: old // ( if ((old.format or "sdist") == "wheel") then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {setuptools = [];});})) (old: old // ( {
>>>>>>> e4e331fe45e5220ba2341cba0ded308929c661ea
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
=======
{final, pkgs, ...}
        : old: {
>>>>>>> 4c6cd0a0008ce45666f5dd2c04ee270b596aea4b
  postInstall =
    old.postInstall
    or ""
    + ''
      rm -rf $out/${final.python.sitePackages}/docs
    '';
}
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD

        
=======
))];
            in
            pkgs.lib.trivial.pipe old funcs
    
>>>>>>> e4e331fe45e5220ba2341cba0ded308929c661ea
=======

        
>>>>>>> 01053e2ed30446105e78e3c6a6d86dd129e42b2e
=======

        
>>>>>>> c0969091896fdd3c5459e332658c3b9de30953a5
=======

        
>>>>>>> b773ac0803f9f9345ddd5254e856989c44d2ebe9
=======

        
>>>>>>> 4c6cd0a0008ce45666f5dd2c04ee270b596aea4b

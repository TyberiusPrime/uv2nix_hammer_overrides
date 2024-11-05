<<<<<<< HEAD
{final, pkgs, ...}
        : old: {
=======
{resolveBuildSystem, final, pkgs, ...}
        :
            old:
            let funcs = [(old: old // ( if ((old.format or "sdist") == "wheel") then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {setuptools = [];});})) (old: old // ( {
>>>>>>> e4e331fe45e5220ba2341cba0ded308929c661ea
  postInstall =
    old.postInstall
    or ""
    + ''
      rm -rf $out/${final.python.sitePackages}/docs
    '';
}
<<<<<<< HEAD

        
=======
))];
            in
            pkgs.lib.trivial.pipe old funcs
    
>>>>>>> e4e331fe45e5220ba2341cba0ded308929c661ea

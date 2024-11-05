<<<<<<< HEAD
{pkgs, ...}
        : old: {
=======
{resolveBuildSystem, final, pkgs, ...}
        :
            old:
            let funcs = [(old: old // ( if ((old.format or "sdist") == "wheel") then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {setuptools = [];});})) (old: old // ( {
>>>>>>> 4c6cd0a0008ce45666f5dd2c04ee270b596aea4b
  postPatch = pkgs.lib.optionalString (old.format or "sdist" == "sdist") ''
    substituteInPlace setup.py --replace-warn "conda_install_mode = False" "conda_install_mode = True"
  '';
}
<<<<<<< HEAD

        
=======
))];
            in
            pkgs.lib.trivial.pipe old funcs
    
>>>>>>> 4c6cd0a0008ce45666f5dd2c04ee270b596aea4b

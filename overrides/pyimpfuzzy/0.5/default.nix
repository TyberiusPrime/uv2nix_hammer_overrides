<<<<<<< HEAD
{pkgs, ...}
        : old: {
  buildInputs = [pkgs.ssdeep];
}

        
=======
{resolveBuildSystem, final, pkgs, ...}
        :
            old:
            let funcs = [(old: old // ( if ((old.format or "sdist") == "wheel") then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {setuptools = [];});})) (old: old // ( {
  buildInputs = [pkgs.ssdeep];
}
))];
            in
            pkgs.lib.trivial.pipe old funcs
    
>>>>>>> 4b86a575a869296520b288fd58e6535e94de812b

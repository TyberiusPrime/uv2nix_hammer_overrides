<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> b47eefa9fb6a201149524de49c7bdaec5b6756dd
=======
>>>>>>> f2b8b3a3c4ff2640af23e58184de2b188f6f872e
{pkgs, ...}
        : old: {
  buildInputs = [pkgs.ssdeep];
}

<<<<<<< HEAD
<<<<<<< HEAD
        
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
=======
        
>>>>>>> b47eefa9fb6a201149524de49c7bdaec5b6756dd
=======
        
>>>>>>> f2b8b3a3c4ff2640af23e58184de2b188f6f872e

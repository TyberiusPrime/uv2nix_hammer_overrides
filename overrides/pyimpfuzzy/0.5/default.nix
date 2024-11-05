<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> b47eefa9fb6a201149524de49c7bdaec5b6756dd
=======
>>>>>>> f2b8b3a3c4ff2640af23e58184de2b188f6f872e
=======
>>>>>>> b773ac0803f9f9345ddd5254e856989c44d2ebe9
=======
>>>>>>> 4c6cd0a0008ce45666f5dd2c04ee270b596aea4b
=======
>>>>>>> d98e7f2e6a7fb2349d4572fe463b8b85bb9b9d87
{pkgs, ...}
        : old: {
  buildInputs = [pkgs.ssdeep];
}

<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
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
=======
        
>>>>>>> b773ac0803f9f9345ddd5254e856989c44d2ebe9
=======
        
>>>>>>> 4c6cd0a0008ce45666f5dd2c04ee270b596aea4b
=======
        
>>>>>>> d98e7f2e6a7fb2349d4572fe463b8b85bb9b9d87

{resolveBuildSystem, final, pkgs, ...}
        :
            old:
            let funcs = [(old: old // ( if ((old.passthru.format or "sdist") == "wheel") then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ [pkgs.eigen] ++ ( resolveBuildSystem {pybind11 = [];setuptools = [];wheel = [];});})) (old: old // ( if (old.format or "sdist" == "sdist")
then {
  postConfigure = ''
    substituteInPlace setup.py \
      --replace-fail "/usr/include/eigen3/" "${pkgs.eigen}/include/eigen3/"
  '';
}
else {}
))];
            in
            pkgs.lib.trivial.pipe old funcs
    
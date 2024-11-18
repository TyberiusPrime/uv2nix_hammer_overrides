{final, helpers, pkgs, resolveBuildSystem, ...}
        :
            old:
            let funcs = [(old: old // ( if (helpers.isWheel old) then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ [pkgs.gfortran] ++ ( resolveBuildSystem {docutils = [];h5py = [];numpy = [];pip = [];pytest = [];setuptools = [];setuptools-scm = [];wheel = [];});})) (old: old // ( {
  postPatch = ''
  echo '[tool.setuptools_scm]' >> pyproject.toml
  cat pyproject.toml
  '';
}
))];
            in
            pkgs.lib.trivial.pipe old funcs
    
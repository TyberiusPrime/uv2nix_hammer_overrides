{helpers, resolveBuildSystem, final, pkgs, ...}
        :
            old:
            let funcs = [(old: old // ( if (helpers.isWheel old) then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {cython = [];numpy = [];setuptools = [];setuptools-scm = [];wheel = [];});postPatch = (old.postPatch or "")+(''
                ${helpers.tomlreplace} pyproject.toml build-system.requires "[]"
        '');})) (old: old // ( {
  postInstall =
    old.postInstall or ""
    + ''
      rm $out/lib/python${final.python.pythonVersion}/site-packages/tests/*
    '';
}
))];
            in
            pkgs.lib.trivial.pipe old funcs
    
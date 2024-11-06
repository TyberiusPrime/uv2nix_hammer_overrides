{resolveBuildSystem, final, pkgs, ...}
        :
            old:
            let funcs = [(old: old // ( if ((old.passthru.format or "sdist") == "wheel") then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {cmake = [];numpy = [];pip = [];scikit-build = [];setuptools = [];});})) (old: old // ( {
  postPatch = pkgs.lib.optional ((old.passthru.format or "sdist") == "sdist") ''
    sed -i pyproject.toml -e 's/numpy==[0-9]\+\.[0-9]\+\.[0-9]\+;/numpy;/g'
    sed -i pyproject.toml -e 's/setuptools==[0-9.]\+/setuptools/g'
    # somehow the type information doesn't get build
    substituteInPlace setup.py --replace-fail '[ r"python/cv2/py.typed" ] if sys.version_info >= (3, 6) else []' "[]" \
    --replace-fail 'rearrange_cmake_output_data["cv2.typing"] = ["python/cv2" + r"/typing/.*\.py"]' "pass"
  '';
}
))];
            in
            pkgs.lib.trivial.pipe old funcs
    
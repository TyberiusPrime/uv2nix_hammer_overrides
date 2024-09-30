{
  postPatch = ''
    sed -i pyproject.toml -e 's/numpy==[0-9]\+\.[0-9]\+\.[0-9]\+;/numpy;/g'
    # somehow the type information doesn't get build
    substituteInPlace setup.py --replace-fail '[ r"python/cv2/py.typed" ] if sys.version_info >= (3, 6) else []' "[]" \
    --replace-fail 'rearrange_cmake_output_data["cv2.typing"] = ["python/cv2" + r"/typing/.*\.py"]' "pass"
  '';
}

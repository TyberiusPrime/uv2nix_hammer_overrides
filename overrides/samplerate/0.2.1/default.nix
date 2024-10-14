{pkgs, ...}
        : old: {
  # from nixpkgs
  postPatch = ''
    # unvendor pybind11, libsamplerate
    rm -r external
    substituteInPlace CMakeLists.txt \
      --replace-fail "add_subdirectory(external)" "find_package(pybind11 REQUIRED)"
  '';
  buildInputs = old.buildInputs or [] ++ [pkgs.libsamplerate];
  dontUseCmakeConfigure = true;
  preCheck = ''
    rm -rf samplerate
  '';
}

        
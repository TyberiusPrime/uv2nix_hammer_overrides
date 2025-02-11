{final, pkgs, ...}
        : old: let
  inherit (pkgs) lib;
  mupdf-cxx = pkgs.mupdf.override {
    enableOcr = true;
    enableCxx = true;
    enablePython = true;
    python3 = final.python;
  };
in
{
  # straight from nixpkgs.
  env = {
    # force using system MuPDF (must be defined in environment and empty)
    PYMUPDF_SETUP_MUPDF_BUILD = "";
    # Setup the name of the package away from the default 'libclang'
    PYMUPDF_SETUP_LIBCLANG = "clang";
    # provide MuPDF paths
    PYMUPDF_MUPDF_LIB = "${lib.getLib mupdf-cxx}/lib";
    PYMUPDF_MUPDF_INCLUDE = "${lib.getDev mupdf-cxx}/include";
  };
  nativeBuildInputs = old.nativeBuildInputs ++ [
    final.libclang
    final.swig
    final.psutil
    final.setuptools
  ];

  buildInputs =
    with pkgs;
    (
      [
        freetype
        harfbuzz
        openjpeg
        jbig2dec
        libjpeg_turbo
        gumbo
      ]
      ++ lib.optionals (pkgs.stdenv.system == "x86_64-darwin") [ memstreamHook ]
    );

  # TODO: manually add mupdf rpath until upstream fixes it
  preFixup = lib.optionalString pkgs.stdenv.hostPlatform.isDarwin ''
    echo 'post install'
    for lib in */*.so $out/${final.python.sitePackages}/*/*.so; do
      install_name_tool -add_rpath ${lib.getLib mupdf-cxx}/lib "$lib"
    done
  '';
  preCheck = ''
    export PATH="$out/bin:$PATH";
  '';

  disabledTests = [
    # Do not lint code
    "test_codespell"
    "test_pylint"
    "test_flake8"
    # Upstream recommends disabling these when not using bundled MuPDF build
    "test_color_count"
    "test_3050"
    "test_textbox3"
  ];
}

        
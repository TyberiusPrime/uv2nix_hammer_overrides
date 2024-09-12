let
  localPython = final.python.withPackages (ps:
    with ps; [
      setuptools
      numpy
      six
    ]);
in {
  pythonOutputDistPhase = ":";

  DOXYGEN = "${pkgs.doxygen}/bin/doxygen";

  nativeBuildInputs = with pkgs;
    [
      which
      doxygen
      gtk3
      pkg-config
      autoPatchelfHook
      final.sip
    ]
    ++ old.nativeBuildInputs or [];

  buildInputs = with pkgs;
    [
      gtk3
      webkitgtk
      ncurses
      SDL2
      xorg.libXinerama
      xorg.libSM
      xorg.libXxf86vm
      xorg.libXtst
      xorg.xorgproto
      gst_all_1.gstreamer
      gst_all_1.gst-plugins-base
      libGLU
      libGL
      libglvnd
      mesa
    ]
    ++ old.buildInputs or [];

  buildPhase = ''
    ${localPython.interpreter} build.py -v build_wx
    ${localPython.interpreter} build.py -v dox etg --nodoc sip
    ${localPython.interpreter} build.py -v build_py
  '';

  installPhase = ''
    ${localPython.interpreter} setup.py install --skip-build --prefix=$out
    wrapPythonPrograms

  '';
}

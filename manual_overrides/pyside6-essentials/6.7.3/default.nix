{
  patches = [
    # stripped down version of https://github.com/pyside/pyside-setup/commit/a0d68856d67ce6e178e3cfc2fccc236707e02fcd
    # FIXME: remove in next release
    ./qt-6.7.1.patch
  ];

  sourceRoot = "pyside-setup-everywhere-src-${old.version}/sources/${old.pname}";

  # FIXME: cmake/Macros/PySideModules.cmake supposes that all Qt frameworks on macOS
  # reside in the same directory as QtCore.framework, which is not true for Nix.
  postPatch = pkgs.lib.optionalString pkgs.stdenv.isLinux ''
    # Don't ignore optional Qt modules
    substituteInPlace cmake/PySideHelpers.cmake \
      --replace-fail \
        'string(FIND "''${_module_dir}" "''${_core_abs_dir}" found_basepath)' \
        'set (found_basepath 0)'
  '';

  nativeBuildInputs =
    old.nativeBuildInputs
    or []
    ++ [
      pkgs.cmake
      pkgs.ninja
      final.python
    ]
    ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [pkgs.moveBuildTree];
  buildInputs =
    (old.buildInputs or [])
    ++ (
      with final.qt6;
        [
          # required
          qtbase
          final.ninja
          final.packaging
          final.setuptools
        ]
        ++ lib.optionals stdenv.isLinux [
          # optional
          qt3d
          qtcharts
          qtconnectivity
          qtdatavis3d
          qtdeclarative
          qthttpserver
          qtmultimedia
          qtnetworkauth
          qtquick3d
          qtremoteobjects
          qtscxml
          qtsensors
          qtspeech
          qtsvg
          qttools
          qtwebchannel
          qtwebengine
          qtwebsockets
        ]
    );
}

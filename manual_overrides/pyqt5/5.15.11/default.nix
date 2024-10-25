let
  inherit (pkgs) lib;
  selectQt5 = version: let
    selector = builtins.concatStringsSep "" (lib.take 2 (builtins.splitVersion version));
  in
    pkgs."qt${selector}" or pkgs.qt5;

  qt5 = selectQt5 prev.pyqt5-qt5.version;
  pyQt5Modules = qt5:
    with qt5; [
      qt3d
      qtbase
      qtcharts
      qtconnectivity
      qtdatavis3d
      qtdeclarative
      qtgamepad
      qtlocation
      qtmultimedia
      qtsensors
      qtserialport
      qtsvg
      qtwebchannel
      qtwebengine
      qtwebsockets
      qtx11extras
      qtxmlpatterns
      qtquick3d
      qtremoteobjects
      qttools
    ];
in (
  if (old.format or "sdist" == "sdist")
  then {
    postPatch = ''
      # Confirm license, if project.py exists
      if test -f project.py; then
        sed -i s/"if tool == 'pep517':"/"if True:"/ project.py
      fi
    '';

    dontConfigure = true;
    dontWrapQtApps = true;
    nativeBuildInputs =
      old.nativeBuildInputs
      or []
      ++ pyQt5Modules qt5
      ++ [
        final.pyqt-builder
        final.sip
      ];
    buildInputs = old.buildInputs or [] ++ pyQt5Modules qt5;
    autoPatchelfIgnoreMissingDeps = ["libQt5TextToSpeech.so.5"]; # no clue if this is correct.
  }
  else {
    buildInputs = old.buildInputs or [] ++ pyQt5Modules qt5;
    autoPatchelfIgnoreMissingDeps = ["libQt5TextToSpeech.so.5"]; # no clue if this is correct.
  }
)

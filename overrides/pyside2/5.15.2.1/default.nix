{
  helpers,
  prev,
  pkgs,
  ...
}:
old:
let
  inherit (pkgs) lib;
  selectQt5 =
    version:
    let
      selector = builtins.concatStringsSep "" (lib.take 2 (builtins.splitVersion version));
    in
    pkgs."qt${selector}" or pkgs.qt5;

  qt5 = selectQt5 prev.pyside2.version;
  pyQt5Modules =
    qt5: with qt5; [
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
in
if (!helpers.isWheel old) then
    {
      # unlikely to work as is
      dontWrapQtApps = true;

    }
  else
    {
      buildInputs =
        old.buildInputs or [ ]
        ++ (pyQt5Modules qt5)
        ++ [
          pkgs.cairo
          pkgs.cups
          pkgs.gdk
          pkgs.pango
          pkgs.speechd
        ];
      dontWrapQtApps = true;

      #autoPatchelfIgnoreMissingDeps = ["libQt5TextToSpeech.so.5" "libQt5Bodymovin.so.5"]; # no clue if this is correct.
    }

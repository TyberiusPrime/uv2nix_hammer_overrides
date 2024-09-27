{ prev, pkgs, ... }:
old:
let
  funcs = [
    (
      old:
      old
      // {
        buildInputs = old.buildInputs or [ ] ++ [
          pkgs.freetype
          pkgs.unixODBC
        ];
      }
    )
    (
      old:
      old
      // (
        let
          inherit (pkgs) lib;
          selectQt5 =
            version:
            let
              selector = builtins.concatStringsSep "" (lib.take 2 (builtins.splitVersion version));
            in
            pkgs."qt${selector}" or pkgs.qt5;

          qt5 = selectQt5 prev.pyqt5-qt5.version;
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
            ];
        in
        {
          dontWrapQtApps = true;
          propagatedBuildInputs =
            old.propagatedBuildInputs or [ ]
            ++ pyQt5Modules qt5
            ++ [
              pkgs.gtk3
              pkgs.speechd
              pkgs.postgresql
              pkgs.unixODBC
            ];
          autoPatchelfIgnoreMissingDeps = [ "libQt5Bodymovin.so.5" ]; # no clue if this is correct.
        }
      )
    )
  ];
in
pkgs.lib.trivial.pipe old funcs

{final, pkgs, ...}
        : old: {
  dontWrapQtApps = true;
  buildInputs =
    (old.buildInputs or [])
    ++ [
      pkgs.qt6.full
      pkgs.gtk3
      pkgs.libxkbcommon
      pkgs.postgresql.lib
    ];
  autoPatchelfIgnoreMissingDeps = [
    "libmysqlclient.so.21"
    "libmimerapi.so"
    "libQt6EglFsKmsGbmSupport.so*"
  ];
  # Somehow `autopatchelf` does not find the `shiboken6` library.
  preFixup = ''
    addAutoPatchelfSearchPath ${final.shiboken6}/${final.python.sitePackages}/shiboken6
  '';
}
))];
            in
            pkgs.lib.trivial.pipe old funcs
    
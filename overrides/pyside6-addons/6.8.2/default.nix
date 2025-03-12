{final, pkgs, ...}
        : old: {
  dontWrapQtApps = true;
  buildInputs =
    (old.buildInputs or [])
    ++ [
      pkgs.qt6.full
      pkgs.speechd
      pkgs.pcsclite
    ];
  # Somehow `autopatchelf` does not find the `shiboken6` and `pyside-essentials` libraries.
  preFixup = ''
    addAutoPatchelfSearchPath ${final.shiboken6}/${final.python.sitePackages}/shiboken6
    addAutoPatchelfSearchPath ${final.pyside6-essentials}/${final.python.sitePackages}/PySide6
    # addAutoPatchelfSearchPath $out/${final.python.sitePackages}/PySide6
  '';
}

        
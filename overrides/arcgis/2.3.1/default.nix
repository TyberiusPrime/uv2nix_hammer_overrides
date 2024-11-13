{pkgs, ...}
        : old: {
  postPatch = pkgs.lib.optionalString (old.passthru.format or "sdist" == "sdist") ''
    substituteInPlace setup.py --replace-warn "conda_install_mode = False" "conda_install_mode = True"
  '';
}
        
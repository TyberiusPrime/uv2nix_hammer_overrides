{helpers, pkgs, ...}
        : old: {
  postPatch = pkgs.lib.optionalString (!helpers.isWheel old) ''
    substituteInPlace setup.py --replace-warn "conda_install_mode = False" "conda_install_mode = True"
  '';
}

        
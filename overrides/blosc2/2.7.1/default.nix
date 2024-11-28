{helpers, pkgs, ...}
        : old: {
  postInstall =
    (old.postInstall or "")
    + (pkgs.lib.optionalString (helpers.isWheel old) ''
      echo idk
    '');
}

        
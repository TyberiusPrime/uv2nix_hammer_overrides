{final, pkgs, ...}
        : old: {
  # from nixpkgs
  nativeBuildInputs = old.nativeBuildInputs or [] ++ [pkgs.pkg-config];
  buildInputs = old.buildInputs or [] ++ [
    pkgs.systemd
    pkgs.libyaml
    pkgs.openzwave
    final.cython_0
  ];

  # primary location for the .xml files is in /etc/openzwave so we override the
  # /usr/local/etc lookup instead as that allows us to dump new .xml files into
  # /etc/openzwave if needed
  postPatch = old.postPatch or "" + pkgs.lib.optionalString (old.passthru.format or "sdist" == "sdist") ''
    substituteInPlace src-lib/libopenzwave/libopenzwave.pyx \
      --replace /usr/local/etc/openzwave ${pkgs.openzwave}/etc/openzwave
  '';
}
        
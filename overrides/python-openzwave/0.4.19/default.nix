<<<<<<< HEAD
{final, pkgs, ...}
        : old: {
=======
{resolveBuildSystem, final, pkgs, ...}
        :
            old:
            let funcs = [(old: old // ( if ((old.format or "sdist") == "wheel") then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {setuptools = [];});})) (old: old // ( {
>>>>>>> 01053e2ed30446105e78e3c6a6d86dd129e42b2e
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
  postPatch = old.postPatch or "" + pkgs.lib.optionalString (old.format or "sdist" == "sdist") ''
    substituteInPlace src-lib/libopenzwave/libopenzwave.pyx \
      --replace /usr/local/etc/openzwave ${pkgs.openzwave}/etc/openzwave
  '';
}
<<<<<<< HEAD

        
=======
))];
            in
            pkgs.lib.trivial.pipe old funcs
    
>>>>>>> 01053e2ed30446105e78e3c6a6d86dd129e42b2e

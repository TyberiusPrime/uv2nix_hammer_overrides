{
  postPatch = ''
    substituteInPlace setup.py \
      --replace-fail "\"/usr/include\"," "\"${pkgs.libsndfile.dev}/include\", \"${pkgs.portaudio}/include\", \"${pkgs.portmidi}/include\", \"${pkgs.liblo}/include\","
  '';
  buildInputs = [
    pkgs.libsndfile
    pkgs.portaudio
    pkgs.portmidi
    pkgs.liblo
  ];
}

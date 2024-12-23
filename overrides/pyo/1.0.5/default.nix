{
  helpers,
  pkgs,
  resolveBuildSystem,
  ...
}:
old:
let
  funcs = [
    (
      old:
      old
      // (
        if (helpers.isWheel old) then
          { }
        else
          { nativeBuildInputs = old.nativeBuildInputs or [ ] ++ (resolveBuildSystem { setuptools = [ ]; }); }
      )
    )
    (
      old:
      old
      // {
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
    )
  ];
in
pkgs.lib.trivial.pipe old funcs

{
  nativeBuildInputs =
    old.nativeBuildInputs
    or []
    ++ pkgs.lib.optionals
    ((helpers.isWheel old)
      && pkgs.stdenv.isLinux) [
      pkgs.libjack2
      pkgs.alsa-lib.out
    ]
    ++ pkgs.lib.optionals
    ((helpers.isWheel old)
      && pkgs.stdenv.isDarwin) [
      pkgs.CoreAudio
      pkgs.CoreMIDI
      pkgs.pkgs.CoreServices
      pkgs.Foundation
    ];
  builtInputs =
    old.builtInputs
    or []
    ++ pkgs.lib.optionals pkgs.stdenv.isLinux [
      pkgs.libjack2
      pkgs.alsa-lib.out
    ]
    ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [
      pkgs.CoreAudio
      pkgs.CoreMIDI
      pkgs.pkgs.CoreServices
      pkgs.Foundation
    ];
}

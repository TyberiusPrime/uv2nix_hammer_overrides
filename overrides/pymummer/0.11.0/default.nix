{ pkgs, ... }:
old:
let
  mummer = pkgs.stdenv.mkDerivation {
    name = "mummer";
    version = "4.0.0";
    src = pkgs.fetchurl {
      # for github, we'd need yaggo as well which is not in nixpkgs
      url = "https://github.com/mummer4/mummer/releases/download/v4.0.0rc1/mummer-4.0.0rc1.tar.gz";
      sha256 = "sha256-hQBq2y1lOcL3OMPjuxS1i7b2LNbGyl7eiEqHrnbgfR0=";
    };
    nativeBuildInputs = [
      pkgs.swig
      pkgs.autoreconfHook
      pkgs.perl538
    ];
    installPhase = ''
      find .
      aoeu
    '';
  };
in
{
  buildInputs = old.buildInputs or [ ] ++ [ mummer ];
}

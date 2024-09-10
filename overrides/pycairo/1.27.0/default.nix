{ final, pkgs, ... }:
old:
if ((old.format or "sdist") == "wheel") then
  { buildInputs = old.buildInputs or [ ] ++ [ pkgs.cairo ]; }
else
  {
    buildInputs = old.buildInputs or [ ] ++ [ pkgs.cairo ];
    env = { };
    nativeBuildInputs =
      old.nativeBuildInputs or [ ]
      ++ [
        pkgs.meson
        pkgs.pkg-config
      ]
      ++ [ final.meson-python ];
    preBuild = ''
      cd /build
      cd ${old.pname}-${old.version}
    '';
  }

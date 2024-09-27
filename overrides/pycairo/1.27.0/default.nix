{ resolveBuildSystem, pkgs, ... }:
old:
if ((old.format or "sdist") == "wheel") then
  { buildInputs = old.buildInputs or [ ] ++ [ pkgs.cairo ]; }
else
  {
    buildInputs = old.buildInputs or [ ] ++ [ pkgs.cairo ];
    nativeBuildInputs =
      old.nativeBuildInputs or [ ]
      ++ [
        pkgs.meson
        pkgs.pkg-config
      ]
      ++ (resolveBuildSystem { meson-python = [ ]; });
    preBuild = [
      old.preBuild or ""
      ''
        cd /build
        cd ${old.pname}-${old.version}
      ''
    ];
  }

{
  helpers,
  pkgs,
  resolveBuildSystem,
  ...
}:
old:
if (helpers.isWheel old) then
  {
    buildInputs = old.buildInputs or [ ] ++ [
      pkgs.glib
      pkgs.nspr
      pkgs.nss
      pkgs.xorg.libX11
    ];
  }
else
  {
    buildInputs = old.buildInputs or [ ] ++ [
      pkgs.glib
      pkgs.nspr
      pkgs.nss
      pkgs.xorg.libX11
    ];
    nativeBuildInputs = old.nativeBuildInputs or [ ] ++ (resolveBuildSystem { setuptools = [ ]; });
  }

{ resolveBuildSystem, pkgs, ... }:
old:
if ((old.passthru.format or "sdist") == "wheel") then
  { }
else
  {
    nativeBuildInputs =
      old.nativeBuildInputs or [ ] ++ [ pkgs.krb5Full ] ++ (resolveBuildSystem { setuptools = [ ]; });
  }

{ resolveBuildSystem, ... }:
old:
if ((old.format or "sdist") == "wheel") then
  { }
else
  { nativeBuildInputs = old.nativeBuildInputs or [ ] ++ (resolveBuildSystem { poetry-core = [ ]; }); }

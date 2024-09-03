{ final, ... }:
old:
if (old.format == "wheel") then
  { }
else
  { nativeBuildInputs = old.nativeBuildInputs or [ ] ++ [ final.setuptools ]; }

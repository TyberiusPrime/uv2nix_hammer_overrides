{ final, ... }:
old:
if ((old.format or "sdist") == "wheel") then
  { }
else
  {
    nativeBuildInputs = old.nativeBuildInputs or [ ] ++ [ final.setuptools ];
    postPatch = "touch /build/adapt-parser-1.0.0/requirements.txt";
  }

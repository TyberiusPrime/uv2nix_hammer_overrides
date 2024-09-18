{ final, ... }:
old:
if ((old.format or "sdist") == "wheel") then
  { }
else
  {
    env = {
      dontCheckRuntimeDeps = true;
    };
    nativeBuildInputs = old.nativeBuildInputs or [ ] ++ [ final.setuptools ];
  }

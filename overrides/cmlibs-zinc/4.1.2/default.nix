{ pkgs, ... }:
old:
if ((old.format or "sdist") == "wheel") then
  {
    buildInputs = old.buildInputs or [ ] ++ [
      pkgs.freetype
      pkgs.libGLU
      pkgs.libxml2
      pkgs.xz
    ];
  }
else
  {
    buildInputs = old.buildInputs or [ ] ++ [
      pkgs.freetype
      pkgs.libGLU
      pkgs.libxml2
      pkgs.xz
    ];
  }

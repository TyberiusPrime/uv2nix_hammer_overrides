{ final, pkgs, ... }:
old:
let
  funcs = [
    (
      old:
      old
      // (
        if ((old.format or "sdist") == "wheel") then
          { buildInputs = old.buildInputs or [ ] ++ [ pkgs.ncurses ]; }
        else
          {
            buildInputs = old.buildInputs or [ ] ++ [ pkgs.ncurses ];
            nativeBuildInputs = old.nativeBuildInputs or [ ] ++ [ final.setuptools ];
          }
      )
    )
    (
      old:
      old
      // {
        postPatch =
          old.postPatch or ""
          + ''
            substituteInPlace "setup.py" --replace-fail "/bin/bash" "${pkgs.bash}/bin/bash"
          '';
      }
    )
  ];
in
pkgs.lib.trivial.pipe old funcs

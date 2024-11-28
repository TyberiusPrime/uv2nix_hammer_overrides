{pkgs, prev, ...}
        : old: {

  postBuild = ''
    ${prev.python}/bin/python xkbcommon/ffi_build.py
  '';
}

        
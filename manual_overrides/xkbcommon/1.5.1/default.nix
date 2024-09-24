{
  
  postBuild = ''
    ${prev.python}/bin/python xkbcommon/ffi_build.py
  '';
}

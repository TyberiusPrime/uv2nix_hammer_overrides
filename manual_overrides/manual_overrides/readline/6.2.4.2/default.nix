{
  postPatch =
    old.postPatch or ""
    + ''
      substituteInPlace "setup.py" --replace-fail "/bin/bash" "${pkgs.bash}/bin/bash"
    '';
}

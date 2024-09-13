{
  postPatch = ''
  cat setup.py
  substituteInPlace "setup.py" \
    --replace-fail "'nose>=1.0'" ""
  '';
}

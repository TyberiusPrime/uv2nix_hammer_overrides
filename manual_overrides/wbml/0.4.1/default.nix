{
  postInstall = old.postInstall or "" + ''
      rm $out/lib/python${final.python.pythonVersion}/site-packages/tests/*.py
  '';
}

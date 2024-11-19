if (helpers.isWheel old)
then {
  postInstall = ''
    rm $out/${final.python.sitePackages}/olefile/olefile2.py
  '';
}
else {
}

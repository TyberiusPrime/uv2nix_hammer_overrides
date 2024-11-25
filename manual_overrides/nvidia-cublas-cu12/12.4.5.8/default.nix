{
  postInstall =
    old.postInstall or ""
    + ''
      rm -rf $out/${final.python.sitePackages}/nvidia/__pycache__/__init__*
    '';
}

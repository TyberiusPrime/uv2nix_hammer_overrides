{
  postInstall =
    old.postInstall or ""
    + ''
      rm -rf $out/${final.python.sitePackages}/resolver
    '';
}

{
  postInstall =
    old.postInstall
    or ""
    + ''
      rm -rf $out/${final.python.sitePackages}/licenses
      rm -rf $out/${final.python.sitePackages}/docs
    '';
}

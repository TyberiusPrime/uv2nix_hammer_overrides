{
  postInstall =
    old.postInstall or ""
    + ''
      rm -rf $out/${final.python.sitePackages}/docs/
      rm -rf $out/${final.python.sitePackages}/tests/
      rm -rf $out/${final.python.sitePackages}/examples/
    '';
}

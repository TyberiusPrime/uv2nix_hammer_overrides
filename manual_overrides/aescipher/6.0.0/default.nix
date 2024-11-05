{
  postInstall =
    old.postInstall
    or ""
    + ''
      rm -rf $out/${final.python.sitePackages}/README.md
      rm -rf $out/${final.python.sitePackages}/requirements.txt
    '';
}

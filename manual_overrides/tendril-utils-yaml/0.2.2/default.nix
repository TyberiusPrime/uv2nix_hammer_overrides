{
  # make it uniform to the other tendril packages
  postInstall = ''
    cp ${./__init__.py} "$out/${final.python.sitePackages}/tendril/utils/__init__.py"
    cp ${./__init__.py} "$out/${final.python.sitePackages}/tendril/__init__.py"
  '';
}

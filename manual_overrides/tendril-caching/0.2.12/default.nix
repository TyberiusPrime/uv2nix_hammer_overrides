{
  # remove final empty new line from __init__.py
  postInstall = ''
    sed -i '$d' $out/${final.python.sitePackages}/tendril/__init__.py
  '';
}

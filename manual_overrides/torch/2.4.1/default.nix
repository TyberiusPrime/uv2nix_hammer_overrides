{
  postFixup = ''
    rm -rf $out/${final.python.sitePackages}/nvidia/{__pycache__,__init__.py}
    ln -sfn $out/${final.python.sitePackages}/nvidia/*/lib/lib*.so* $out/lib
  '';
}

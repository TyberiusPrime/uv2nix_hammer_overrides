{final, pkgs, ...}
        : old: {
  postInstall = ''
    cp ${./__init__.py} "$out/${final.python.sitePackages}/azureml/__init__.py"
  '';
}

        
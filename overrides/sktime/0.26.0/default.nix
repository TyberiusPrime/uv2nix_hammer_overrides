{pkgs, final, ...}
        : old: {
  postInstall = ''
    rm $out/lib/python${final.python.pythonVersion}/site-packages/docs/source/conf.py
  '';
}

        
_:
_old: {
  postPatch = ''
    echo '[tool.setuptools_scm]' >> pyproject.toml
    cat pyproject.toml
  '';
}

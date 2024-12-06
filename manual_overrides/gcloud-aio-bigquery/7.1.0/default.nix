{
  postInstall = ''
    rm $out/lib/python3.12/site-packages/gcloud/py.typed
  '';
}

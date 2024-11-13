{
  postInstall =
    old.postInstall or ""
    + ''
      rm $out/docs/* -r
    '';
}

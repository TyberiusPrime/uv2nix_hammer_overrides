{
  postInstall =
    old.postInstall or ""
    + ''
      rm $out/LICENSE
    '';
}

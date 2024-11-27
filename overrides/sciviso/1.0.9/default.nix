{ ... }:
old: {
  postInstall =
    old.postInstall or ""
    + ''
      rm -rf $out/LICENSE
    '';
}

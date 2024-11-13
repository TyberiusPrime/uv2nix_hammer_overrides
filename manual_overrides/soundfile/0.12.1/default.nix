let
  sharedLibExt = pkgs.stdenv.hostPlatform.extensions.sharedLibrary;
  patch = ''
    substituteInPlace soundfile.py \
      --replace "_find_library('sndfile')" "'${pkgs.libsndfile.out}/lib/libsndfile${sharedLibExt}'"
  '';
in
{
  postInstall = ''
    pushd "$out/${final.python.sitePackages}"
    ${patch}
    popd
  '';
}

{final, helpers, pkgs, resolveBuildSystem, ...}
        :
            old:
            let funcs = [(old: old // ( if (helpers.isWheel old) then {} else {nativeBuildInputs = old.nativeBuildInputs or [] ++ ( resolveBuildSystem {setuptools = [];});})) (old: old // ( let
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
))];
            in
            pkgs.lib.trivial.pipe old funcs
    
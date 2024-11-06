{
  INCLUDE_PATH = "${pkgs.hunspell.dev}/include/";
  postPatch = ''
    substituteInPlace setup.py --replace-warn "main_module_kwargs['libraries'] = ['hunspell']" "main_module_kwargs['libraries'] = ['hunspell']; main_module_kwargs['library_dirs'] = ['${pkgs.hunspell.out}/lib']"
  '';
}

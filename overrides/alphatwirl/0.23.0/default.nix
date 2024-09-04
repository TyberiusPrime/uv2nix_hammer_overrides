{ pkgs, final, ... }:
old:
if ((old.format or "sdist") == "wheel") then
  { }
else
  {
    nativeBuildInputs = old.nativeBuildInputs or [ ] ++ [ final.setuptools ];
    postPatch =
      (old.postPatch or "")
      + (pkgs.lib.optionalString (!(final.pythonOlder "3.12")) ''
        if [ -e setup.py ]; then
             substituteInPlace setup.py --replace-quiet "versioneer.get_version()" "'${old.version}'" \
               --replace-quiet "cmdclass=versioneer.get_cmdclass()," "" \
               --replace-quiet "cmdclass=versioneer.get_cmdclass()" ""
        fi
      '');
  }

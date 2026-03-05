if ((old.passthru.format or "sdist") == "wheel") then
  {
    nativeBuildInputs = old.nativeBuildInputs ++ [ pkgs.onetbb ];
    postBuild = ''
      WHEEL_NAME="$(find -name '*.whl')"
      echo $WHEEL_NAME
      ABS_WHEEL_NAME=$(realpath -s $WHEEL_NAME)
      echo $ABS_WHEEL_NAME
      mkdir temp
      ${pkgs.unzip}/bin/unzip "$ABS_WHEEL_NAME" -d temp
      sed -i 's|libtbb\\.so|/lib/libtbb.so|g' temp/numba/np/ufunc/parallel.py 
      unlink $ABS_WHEEL_NAME
      cd temp && ${pkgs.zip}/bin/zip -m -r "$ABS_WHEEL_NAME" *
      cd ..
      rmdir temp # zip move.
    '';
  }
else
  {
  }

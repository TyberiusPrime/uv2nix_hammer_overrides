{
  unpackPhase = ''
    mkdir $name/$version -p
    cd $name/$version && tar xf $src
  '';
}

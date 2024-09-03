{
  bi = newBuildInputs: old: { buildInputs = (old.buildInputs or [ ]) ++ newBuildInputs; };
  nbi = newNativeBuildInputs: old: {
    nativeBuildInputs = (old.nativeBuildInputsor [ ]) ++ newNativeBuildInputs;
  };
}

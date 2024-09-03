{ final, ... }:
old: {
  nativeBuildInputs = old.nativeBuildInputs or [ ] ++ [
    final.meson-python
    final.cython
  ];
}

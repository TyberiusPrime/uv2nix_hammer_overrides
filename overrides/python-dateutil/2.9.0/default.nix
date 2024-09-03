{ final, ... }:
old: {
  nativeBuildInputs = old.nativeBuildInputs or [ ] ++ [
    final.setuptools
    final.setuptools-scm
    final.wheel
  ];
}

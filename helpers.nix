{pkgs}: rec {
  bi = newBuildInputs: old: {buildInputs = (old.buildInputs or []) ++ newBuildInputs;};
  nbi = newNativeBuildInputs: old: {
    nativeBuildInputs = (old.nativeBuildInputsor []) ++ newNativeBuildInputs;
  };
  tomlreplace =
    pkgs.writers.writePython3 "tomlreplace"
    {
      libraries = [pkgs.python3Packages.tomlkit];
      flakeIgnore = [
        "E501"
        "E225"
      ];
    }
    ''
      import tomlkit
      import sys

      filename = sys.argv[1]
      key = sys.argv[2]
      value = sys.argv[3]
      replacement_value = tomlkit.loads("[toplevel]\nval = " + value + "\n")['toplevel']['val']

      print(replacement_value)
      input = tomlkit.load(open(filename, 'rb'))
      parts = key.split(".")
      ref = input
      print(ref)
      for part in parts[:-1]:
          ref = ref[part]
      ref[parts[-1]] = replacement_value

      tomlkit.dump(input, open(filename, "w"))
    '';
  notNull = x: !(builtins.isNull x);

  removePackagesByName = packages: packagesToRemove: let
    lib = pkgs.lib;
    namesToRemove = map lib.getName (lib.filter notNull packagesToRemove);
  in
    lib.filter (x: !(builtins.elem (lib.getName x) namesToRemove)) packages;

  standardMaturin = {
    furtherArgs ? {},
    maturinHook ? pkgs.rustPlatform.maturinBuildHook,
  }: old:
    lib.optionalAttrs (!(old.src.isWheel or false)) (
      {
        cargoDeps = pkgs.rustPlatform.importCargoLock {
          lockFile = ./. + "/overides/${old.pname}/${old.version}/Cargo.lock";
        };
        nativeBuildInputs =
          (old.nativeBuildInputs or [])
          ++ [
            pkgs.rustPlatform.cargoSetupHook
            maturinHook
          ]
          ++ (furtherArgs.nativeBuildInputs or []);
      }
      # furtherargs without nativeBuildInputs
      // lib.attrsets.filterAttrs (name: _value: name != "nativeBuildInputs") furtherArgs
    );
  offlineMaturinHook = pkgs.callPackage ({pkgsHostTarget}:
    pkgs.makeSetupHook {
      name = "offline-maturin-build-hook.sh";
      propagatedBuildInputs = [
        pkgsHostTarget.maturin
        pkgsHostTarget.cargo
        pkgsHostTarget.rustc
      ];
      substitutions = {
        inherit (pkgs.rust.envVars) rustTargetPlatformSpec setEnv;
      };
    }
    ./offline-maturin-build-hook.sh) {};
}

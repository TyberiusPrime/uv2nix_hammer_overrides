# uv2nix_hammer_overrides


[uv2nix](https://github.com/adisbladis/uv2nix) does not contain an override collection by design.

The [uv2nix_hammer](https://github.com/TyberiusPrime/uv2nix_hammer) is a tool to automatically generate such overrides
on demand.

These overrides are then collected in [this repository](https://github.com/TyberiusPrime/uv2nix_hammer_overrides) so that downstream users can easily use uv2nix for the most
common python packages.

Current state (2024-09-18): I have done a sweep through the 15.6k 'most important' python packages, prefering wheels. About 13.4k build, another 1000 have ended up on the [exclusion list](https://github.com/TyberiusPrime/uv2nix_hammer_overrides/blob/main/todo/excluded.toml) for various reasons, and the remaining ~800 are in limbo.


Poetry2nix might also benefit from these overrides, there's an example how to use them below.

Usage:

Example flake.nix:

```nix
{
  description = "A basic flake using uv2nix";

  inputs.uv2nix.url = "github:adisbladis/uv2nix";
  inputs.uv2nix.inputs.nixpkgs.follows = "nixpkgs";

  inputs.uv2nix_hammer_overrides.url = "github:TyberiusPrime/uv2nix_hammer";
  inputs.uv2nix_hammer_overrides.inputs.nixpkgs.follows = "nixpkgs";

  inputs.nixpkgs_master.url = "github:nixos/nixpkgs/master";

  # Disclaimer: Uv2nix is new and experimental.
  # Users are expected to be able to contribute fixes.

  outputs = {
    nixpkgs,
    uv2nix,
    uv2nix_hammer_overrides,
    nixpkgs_master,
    ...
  }: let
    inherit (nixpkgs) lib;

    # Load a uv workspace from a workspace root.
    # Uv2nix treats all uv projects as workspace projects.
    workspace = uv2nix.lib.workspace.loadWorkspace {workspaceRoot = ./.;};

    # Manage overlays
    overlay = let
      # Create overlay from workspace.
      overlay' = workspace.mkOverlay {
        # Prefer prebuilt binary wheels as a package source.
        # Sdists are less likely to "just work" because of the metadata missing from uv.lock.
        # Binary wheels are more likely to, but may still require overrides for library dependencies.
        sourcePreference = "sdist"; # or sourcePreference = "sdist";
        # Optionally customise PEP 508 environment
        # environ = {
        #   platform_release = "5.10.65";
        # };
      };

      # Uv2nix can only work with what it has, and uv.lock is missing essential metadata to perform some builds.
      # This is an additional overlay implementing build fixups.
      # See:
      # - https://adisbladis.github.io/uv2nix/FAQ.html
      # - https://nixos.org/manual/nixpkgs/stable/#overriding-python-packages
      overrides =
        lib.composeExtensions
        (uv2nix_hammer_overrides.overrides)
        (_final: prev: {
        # if you need even more overrides
        });
      #overrides = ;
    in
      lib.composeExtensions overlay' overrides;

    # This example is only using x86_64-linux
    pkgs = nixpkgs.legacyPackages.x86_64-linux;

    # Create an overriden interpreter
    python = pkgs.python3.override {
      # Note the self argument.
      # It's important so the interpreter/set is internally consistent.
      self = python;
      # Pass composed Python overlay to the interpreter
      packageOverrides = overlay;
    };
  in {
    # 'app' is the name in pyproject.toml after name normalization.
    # See https://packaging.python.org/en/latest/specifications/name-normalization/#normalization

    packages.x86_64-linux.default =
      python.withPackages (p: [p.app]);
    # TODO: A better mkShell withPackages example.
    devShells.x86_64-linux.default = pkgs.mkShell {
      inputsFrom = [python.pkgs.app];
      packages = [pkgs.uv];
    };
    devShells.x86_64-linux.uv = pkgs.mkShell {
      packages = [nixpkgs_master.legacyPackages.x86_64-linux.uv];
    };
  };
}
```


poetry2nix example
```nix
{
  description = "Application packaged using poetry2nix";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/24.05";
    poetry2nix = {
      url = "github:nix-community/poetry2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    uv2nix_hammer_overrides.url = "github:/TyberiusPrime/uv2nix_hammer_overrides";
    uv2nix_hammer_overrides.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    poetry2nix,
    uv2nix_hammer_overrides,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      inherit (poetry2nix.lib.mkPoetry2Nix {inherit pkgs;}) mkPoetryEnv defaultPoetryOverrides;
    in {
      packages = {
        myapp = mkPoetryEnv {
          projectDir = self;
          python = pkgs.python312;
          overrides = [
            # defaultPoetryOverrides # depending on wether you want the poetry2nix overrides as well
            (uv2nix_hammer_overrides.overrides pkgs)
          ];

          preferWheels = true;
        };
      };

      defaultPackage = self.packages.${system}.myapp;

      # Shell for app dependencies.
      devShells.default = pkgs.mkShell {
        inputsFrom = [self.packages.${system}.myapp];
      };

      # Shell for poetry.
      devShells.poetry = pkgs.mkShell {
        packages = [pkgs.poetry];
      };
    });
}
```

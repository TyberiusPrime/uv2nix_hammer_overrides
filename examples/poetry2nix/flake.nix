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

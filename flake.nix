{
  inputs = {
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };
  outputs =
    {
      systems,
      treefmt-nix,
      nixpkgs,
      ...
    }:
    let
      eachSystem = f: nixpkgs.lib.genAttrs (import systems) (system: f nixpkgs.legacyPackages.${system});
      treefmtEval = eachSystem (pkgs: treefmt-nix.lib.evalModule pkgs ./dev/treefmt.nix);
      inherit (nixpkgs) lib;

      overrides_by_version = import ./collected.nix;
      # find the latest version of the override that is older than the current version
      # or if no version is older than the requestd one, find the first one.
      helpers = import ./helpers.nix;
    in
    {
      formatter = eachSystem (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper);
      overrides =
        final: prev:
        (lib.attrsets.mapAttrs (
          #todo: how do they get packages?
          name: available_versions:
          prev.${name}.overridePythonAttrs (
            available_versions.${prev.${name}.version} {
              inherit final prev helpers;
              #pkgs = nixpkgs;
            }
          )
        ) overrides_by_version);
    };
}

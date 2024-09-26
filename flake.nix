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
      version_match =
        name: version:
        let
          versions_available = lib.attrsets.attrNames (overrides_by_version.${name} or { });
          sorted_versions_available = lib.lists.sort lib.versionOlder versions_available;
          older_versions = lib.lists.filter (
            v: ((v == version) || (lib.versionOlder v version))
          ) sorted_versions_available;
        in
        if builtins.length older_versions == 0 then
          (
            if builtins.length sorted_versions_available == 0 then
              throw ("No versions available for " + name)
            else
              builtins.elemAt sorted_versions_available 0 # what happens if sorted_versions_available is empty?
          )
        else
          lib.lists.last older_versions;

      helpers = import ./helpers.nix { pkgs = nixpkgs.legacyPackages.x86_64-linux; };
    in
    {
      formatter = eachSystem (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper);
      overrides =
        nixpkgs_pkgs: final: prev:
        (lib.attrsets.mapAttrs (
          name: available_versions:
          let
            matched_version = version_match name prev.${name}.version;
            resolveBuildSystem = final.resolveBuildSystem or poetry2nix_resolveBuildSystem_adapter;
            poetry2nix_resolveBuildSystem_adapter =
              pyproject-nix-style-build-systems:
              builtins.map (x: final.${x}) (builtins.attrNames pyproject-nix-style-build-systems);
          in
          # poetry2nix or uv2nix with pyproject.nix builders?
          (prev.${name}.overridePythonAttrs or prev.${name}.overrideAttrs) (
            available_versions.${builtins.trace (name + " matched to " + matched_version) matched_version} {
              inherit
                final
                prev
                helpers
                resolveBuildSystem
                ;
              pkgs = nixpkgs_pkgs;
            }
          )
        ) overrides_by_version);
      devShell.x86_64-linux =
        let
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
        in
        pkgs.mkShell { buildInputs = [ pkgs.pre-commit ]; };
    };
}

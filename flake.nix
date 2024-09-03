{
  inputs = {
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };
  outputs = {
    systems,
    treefmt-nix,
    nixpkgs,
    ...
  }: let
    eachSystem = f: nixpkgs.lib.genAttrs (import systems) (system: f nixpkgs.legacyPackages.${system});
    treefmtEval = eachSystem (pkgs: treefmt-nix.lib.evalModule pkgs ./dev/treefmt.nix);
    inherit (nixpkgs) lib;

    overrides_by_version = import ./collected.nix;
    # find the latest version of the override that is older than the current version
    # or if no version is older than the requestd one, find the first one.
    version_match = name: version: let
      versions_available = lib.attrsets.attrNames (overrides_by_version.${name} or {});
      sorted_versions_available = lib.lists.sort lib.versionOlder versions_available;
      older_versions = lib.lists.filter (v: lib.versionOlder v version) sorted_versions_available;
    in
      if builtins.length older_versions == 0
      then
        (
          if builtins.length sorted_versions_available == 0
          then throw ("No versions available for " + name)
          else builtins.elemAt sorted_versions_available 0 # what happens if sorted_versions_available is empty?
        )
      else lib.lists.last older_versions;
  in {
    formatter = eachSystem (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper);
    overrides = final: prev:
      eachSystem (pkgs: let
        helpers = import ./helpers.nix {inherit pkgs;};
      in (lib.attrsets.mapAttrs (
          #todo: how do they get packages?
          name: available_versions: let
            matched_version = version_match name prev.${name}.version;
          in
            prev.${name}.overridePythonAttrs (
              available_versions.${builtins.trace (name + " matched to " + matched_version) matched_version} {
                inherit final prev helpers;
                #pkgs = nixpkgs;
              }
            )
        )
        overrides_by_version));
  };
}

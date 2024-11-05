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
      older_versions =
        lib.lists.filter (
          v: ((v == version) || (lib.versionOlder v version))
        )
        sorted_versions_available;
    in
      if builtins.length older_versions == 0
      then
        (
          if builtins.length sorted_versions_available == 0
          then throw ("No versions available for " + name)
          else builtins.elemAt sorted_versions_available 0 # what happens if sorted_versions_available is empty?
        )
      else lib.lists.last older_versions;

    version_match_no_fallback = name: version: let
      # find the latest version of the override that is older than the current version
      # or if no version is older than the requestd one, don't match an override.
      versions_available = lib.attrsets.attrNames (overrides_by_version.${name} or {});
      sorted_versions_available = lib.lists.sort lib.versionOlder versions_available;
      older_versions =
        lib.lists.filter (
          v: ((v == version) || (lib.versionOlder v version))
        )
        sorted_versions_available;
    in
      if builtins.length older_versions == 0
      then null
      else lib.lists.last older_versions;

    matched_overrides = version_match: nixpkgs_pkgs: final: prev:
      (lib.attrsets.mapAttrs (
          name: available_versions: let
            matched_version = version_match name prev.${name}.version;
            resolveBuildSystem = final.resolveBuildSystem or poetry2nix_resolveBuildSystem_adapter;
            poetry2nix_resolveBuildSystem_adapter = pyproject-nix-style-build-systems:
              builtins.map (x: final.${x}) (builtins.attrNames pyproject-nix-style-build-systems);
            helpers = import ./helpers.nix {pkgs = nixpkgs_pkgs;};
          in
            # poetry2nix or uv2nix with pyproject.nix builders?
            (
              if (matched_version != null)
              then
                (
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
                )
              else (builtins.trace "no version match for ${name}" prev.${name})
            )
        )
        overrides_by_version)
      // {
        cython_0 = prev.cython.overrideAttrs (old: {
          src =
            if ((builtins.trace (old.format or "sdist") (old.format or "sdist")) == "wheel")
            then
              nixpkgs_pkgs.fetchurl {
                url = "https://files.pythonhosted.org/packages/3f/d6/9eed523aeaca42acbaa3e6d3850edae780dc7f8da9df1bf6a2ceb851839c/Cython-0.29.36-py2.py3-none-any.whl";
                sha256 = "sha256-lbsT2L5QdCXQPr4FH5DUsqn9zMZOTzCzVkX9t1QnQus=";
              }
            else
              nixpkgs_pkgs.fetchPypi {
                pname = "Cython";
                version = "0.29.36";
                hash = "sha256-QcDP0tdU44PJ7rle/8mqSrhH0Ml0cHfd18Dctow7wB8=";
              };
        });
      };
  in {
    formatter = eachSystem (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper);
    overrides = matched_overrides version_match;
    overrides_strict = matched_overrides version_match_no_fallback;

    devShell.x86_64-linux = let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in
      pkgs.mkShell {buildInputs = [pkgs.pre-commit];};
  };
}

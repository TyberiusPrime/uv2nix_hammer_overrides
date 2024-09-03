{
  inputs = {
  };
  outputs = {
    self,
    nixpkgs,
  }: let
    inherit (nixpkgs) lib;
    pkgs_with_overrides = let
      dir_contents = builtins.readDir ./overrides;
      subdirs = lib.attrsets.filterAttrs (key: value: value == "directory") dir_contents;
    in
      dir_contents; # todo: turn into list?
    # find the latest version of the override that is older than the current version
    # or if no version is older than the requestd one, find the first one.
    version_match = (
      name: version: let
        dir_contents = builtins.readDir ./overrides/${name};
        subdirs = lib.attrsets.filterAttrs (key: value: value == "directory") dir_contents;
        versions_available = lib.attrsets.attrNames subdirs;
        sorted_versions_available = lib.lists.sort (lib.versionOlder) versions_available;
        older_versions = lib.lists.filter (v: lib.versionOlder v version) sorted_versions_available;
      in
        if builtins.length older_versions == 0
        then builtins.elemAt sorted_versions_available 0 # what happens if sorted_versions_available is empty?
        else lib.lists.last older_versions
    );
    helpers = import ./helpers.nix;
  in {
    overrides = final: prev: (lib.attrsets.mapAttrs
      (
        #todo: how do they get packages?
        name: _ignored:
          prev.${name}.overridePythonAttrs (import ./overrides/${name}/${version_match name prev.${name}.version}/default.nix {
            inherit final prev helpers;
            #pkgs = nixpkgs;
          })
      )
      pkgs_with_overrides);
    override_files =
      lib.attrsets.mapAttrs
      (
        name: _ignored: ./overrides/${name}/${version_match name "0.4"}/default.nix
      )
      pkgs_with_overrides;
  };
}

{
  inputs = {
  };
  outputs = {
    self,
    nixpkgs,
  }: let
    inherit (nixpkgs) lib;
    get_subdirs = dir: let
      dir_contents = builtins.readDir dir;
      subdirs = lib.attrsets.filterAttrs (key: value: value == "directory") dir_contents;
    in
      subdirs; # todo: turn into list?

    pkgs_with_overrides = get_subdirs ./overrides;
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
        then
          (
            if builtins.length sorted_versions_available == 0
            then throw ("No versions available for " + name)
            else builtins.elemAt sorted_versions_available 0 # what happens if sorted_versions_available is empty?
          )
        else lib.lists.last older_versions
    );
    helpers = import ./helpers.nix;
  in {
    overrides = final: prev: (lib.attrsets.mapAttrs
      (
        #todo: how do they get packages?
        name: _ignored: let
          matched_version = version_match name prev.${name}.version;
          path = ./overrides/${name}/${matched_version}/default.nix;
        in
          prev.${name}.overridePythonAttrs (import path {
            inherit final prev helpers;
            #pkgs = nixpkgs;
          })
      )
      pkgs_with_overrides);
  };
}

{
  #from nixpkgs...
  postPatch = ''
    # Preferably upstream would not depend on pg_config because config scripts are incompatible with cross-compilation, however postgresql's pc file is lacking information.
    # some linker flags are added but the linker ignores them because they're incompatible
    # https://github.com/psycopg/psycopg2/blob/89005ac5b849c6428c05660b23c5a266c96e677d/setup.py
    substituteInPlace setup.py \
      --replace-fail "self.pg_config_exe = self.build_ext.pg_config" 'self.pg_config_exe = "${pkgs.lib.getDev pkgs.buildPackages.postgresql}/bin/pg_config"'
  '';
  env = {
    PGDATABASE = "psycopg2_test";
  };

  buildInputs = [pkgs.postgresql] ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [pkgs.openssl];
}

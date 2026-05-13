(pkgs.lib.optionalAttrs (!(helpers.isWheel old)) {
  buildInputs =
    (old.buildInputs or [ ])
    ++ [ pkgs.libpq ]
    ++ pkgs.lib.optionals pkgs.stdenv.hostPlatform.isDarwin [ pkgs.openssl ];

  nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [
    pkgs.postgresql
    pkgs.libpq.pg_config
  ];

  env.PGDATABASE = "psycopg2_test";
})

{
  helpers,
  lib ? pkgs.lib,
  pkgs,
  resolveBuildSystem,
  ...
}: old:
lib.optionalAttrs (!(helpers.isWheel old)) {
  buildInputs =
    old.buildInputs or []
    ++ [pkgs.libpq]
    ++ lib.optionals pkgs.stdenv.hostPlatform.isDarwin [pkgs.openssl];

  nativeBuildInputs =
    old.nativeBuildInputs or []
    ++ [
      pkgs.postgresql
      pkgs.libpq.pg_config
    ]
    ++ (resolveBuildSystem {setuptools = [];});

  env.PGDATABASE = "psycopg2_test";
}

{helpers, pkgs, ...}
        :
            old:
            let funcs = [(old: old // ( if (helpers.isWheel old) then {buildInputs = old.buildInputs or [] ++ [pkgs.mpi];} else {"R_HOME" = "${pkgs.R}";buildInputs = old.buildInputs or [] ++ [pkgs.mpi];})) (old: old // ( {
  autoPatchelfIgnoreMissingDeps = [
    "libmlx5.so.1"
    "libucp.so.0"
    "libucs.so.0"
    "libpmix.so2"
    "liboshmem.so.40"
    "libfabric.so.1"
  ];
}
))];
            in
            pkgs.lib.trivial.pipe old funcs
    
{helpers, pkgs, ...}
        :
            old:
            let funcs = [(old: old // ( {buildInputs = old.buildInputs or [] ++ [pkgs.hwloc];})) (old: old // ( {
  autoPatchelfIgnoreMissingDeps = [ "libhwloc.so.5" ]; # it finds libhwloc.so.15, so I'll go with 'this should work'
}
))];
            in
            pkgs.lib.trivial.pipe old funcs
    
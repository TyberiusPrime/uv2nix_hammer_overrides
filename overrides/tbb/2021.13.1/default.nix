{pkgs, ...}
        : old: {
  autoPatchelfIgnoreMissingDeps = [ "libhwloc.so.5" ]; # it finds libhwloc.so.15, so I'll go with 'this should work'
}

        
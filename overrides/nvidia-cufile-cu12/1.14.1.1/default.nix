{ helpers, ... }:
old:
if (helpers.isWheel old) then
  {
    autoPatchelfIgnoreMissingDeps = [
      "libmlx5.so.1"
      "librdmacm.so.1"
      "libibverbs.so.1"
    ];
  }
else
  {
    env = {
      dontUsePyprojectBytecode = true;
    };
  }

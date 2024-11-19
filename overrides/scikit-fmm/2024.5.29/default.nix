{ pkgs, ... }: old: { nativeBuildInputs = old.nativeBuildInputs ++ [ pkgs.breakpointHook ]; }

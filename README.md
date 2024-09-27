# uv2nix_hammer_overrides


[uv2nix](https://github.com/adisbladis/uv2nix) does not contain an override collection by design.

The [uv2nix_hammer](https://github.com/TyberiusPrime/uv2nix_hammer) is a tool to automatically generate such overrides
on demand.

These overrides are then collected in [this repository](https://github.com/TyberiusPrime/uv2nix_hammer_overrides) so that downstream users can easily use uv2nix for the most
common python packages.

Current state (2024-09-18): I have done a sweep through the 15.6k 'most important' python packages, prefering wheels. About 13.4k build, another 1000 have ended up on the [exclusion list](https://github.com/TyberiusPrime/uv2nix_hammer_overrides/blob/main/todo/excluded.toml) for various reasons, and the remaining ~800 are in limbo.


Poetry2nix might also benefit from these overrides, there's an example how to use them below.

## Usage:

Example flake.nix:

```nix
{{#include examples/uv2nix_pyproject_builder/flake.nix}}
```


poetry2nix example
```nix
{{#include examples/poetry2nix/flake.nix}}
```


## Open tasks:

 - Fix (or exclude) the remaining build failures
 - Redo it without '--wheel', prefering source packages (for the target packages).
 - Mabye do it without preferWheel for *all* packages 


## Faq

### Build error:  Caused by: A path dependency is incompatible with the current platform:

That means the python version in your flake.nix and your pyproject.toml do not match.


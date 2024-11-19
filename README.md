# uv2nix_hammer_overrides


[uv2nix](https://github.com/adisbladis/uv2nix) does not contain an override collection by design.

The [uv2nix_hammer](https://github.com/TyberiusPrime/uv2nix_hammer) is a tool to automatically generate such overrides
on demand.

These overrides are then collected in [this repository](https://github.com/TyberiusPrime/uv2nix_hammer_overrides) so that downstream users can easily use uv2nix for the most
common python packages.

Current state (2024-11-07): I have done a sweep through the 15.6k 'most important' python packages, prefering wheels. About 13.4k build, another 1000 have ended up on the [exclusion list](https://github.com/TyberiusPrime/uv2nix_hammer_overrides/blob/main/todo/excluded.toml) for various reasons, and the remaining ~650 are in limbo.


Poetry2nix might also benefit from these overrides, there's an example how to use them below. Note that poetry2nix builds python packages very differently from uv2nix, namely using nixpkgs python builders which have [all kinds of drawbacks](https://nix-community.github.io/pyproject.nix/build.html#problems-with-nixpkgs-python-builders).

## Usage:

Example [uv2nix flake.nix](examples/uv2nix_pyproject_builder/flake.nix)

Example [poetry2nix flake.nix](examples/poetry2nix/flake.nix)
poetry2nix example


## Scope of the 'sweep'

- Limited to 'important' python packages by some arbitrary definition (downloads, number of dependants, user requess).
- TyberiusPrime will only do x86-64-linux. PRs for other architectures welcome, but they probably need to be upstream in [uv2nix-hammer](https://github.com/TyberiusPrime/uv2nix_hammer)
- TyberiusPrime will not spent time getting cryto (-mining) packages to build.
- TyberiusPrime has a time limit on getting any package running.



## Open tasks:

 - Fix (or exclude) the remaining build failures (we're down to ~650 as of 2024-11-07)
 - Redo it without '--wheel', preferring source packages (for the target packages).
 - Maybe do it without preferWheel for *all* packages 


## Faq


#### My packages still fail:

The first thing you might want to check is if there's a 'Downgrade*' rule in overrides/<package>/rules.toml (or it's dependencies :( ). That might teach you that you have to restrict something else to be 'not the newest version'. Sorry, no automatic checking for that yet.


#### "error: attribute '<some package>' missing" during nix eval
One of your packages (or at least one dependency) has a limbo dependency - it's not declared correctly and uv didn't lock it.
You can add it to the dependencies in you pyproject.toml. 


#### Cython vs Cython_0
Cython recently underwent a non-backwards compatible jump from 0.29 to 1.0.
uv2nix_hammer_overrrides provides the former as cython_0, like nixpkgs does. 
It's not pretty, but it works for now.

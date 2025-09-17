# Binaries

These are found in the `bin/build` directory and have equivalent functions.

<!-- TEMPLATE header 2 -->
[⬅ Parent ](../index.md)
<hr />

These utilities can be accessed via the shell in the PATH:

    ./bin/build/

They are intended to be standalone tools useful for a variety of installation and package management functions:

- [`cannon.sh`](./text.md#cannon) - Same as [`cannon`](./text.md#cannon)
- [`chmod-sh.sh`](./platform.md#makeShellFilesExecutable) - Same as [
  `makeShellFilesExecutable`](./platform.md#makeShellFilesExecutable)
- [`identical-check.sh`](./identical.md#identicalCheck) - Same as [`identicalCheck`](./identical.md#identicalCheck)
- [`map.sh`](./text.md#mapEnvironment) - Same as [`mapEnvironment`](./text.md#mapEnvironment)
- [`new-release.sh`](./version.md#newRelease) - Same as [`newRelease`](./version.md#newRelease)
- [`release-notes.sh`](./git.md#releaseNotes) - Same as [`releaseNotes`](./git.md#releaseNotes)
- [`version-last.sh`](./git.md#gitVersionLast) - Same as [`gitVersionLast`](./git.md#gitVersionLast)
- [`version-list.sh`](./git.md/#gitVersionList) - Same as [`gitVersionList`](./git.md#gitVersionList)

## `tools.sh` to run commands

Do `source tools.sh` to load all functions into the current environment.

You can also do

    ./tools.sh decorate file "$(pwd)"

To run commands directly; note this is slower for larger scripts and can be used when a single function is necessary.

## `identical-repair.sh` repair with semantics

{__buildIdenticalRepair}

## `install-bin-build.sh`

Modify the last line of this file when installing at a different project depth:

    __installPackageConfiguration ../.. "$@"

The `../..` is the relative path from the script to the project root
directory. - [function {fn}]({documentationPath}) - [{summary}]({sourceLink}) will do this for you.

{__installBinBuildURL}

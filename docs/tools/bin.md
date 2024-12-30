# Binaries

These are found in the `bin/build` directory and have equivalent functions.

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

These utilities can be accessed via the shell in the PATH:

    ./bin/build/

They are intended to be standalone tools useful for a variety of installation and package management functions:

- [`cannon.sh`](./text.md#cannon) - Same as [`cannon`](./text.md#cannon)
- [`chmod-sh.sh`](./os.md#makeShellFilesExecutable) - Same as [`makeShellFilesExecutable`](./os.md#makeShellFilesExecutable)
- [`identical-check.sh`](./identical.md#identicalCheck) - Same as [`identicalCheck`](./identical.md#identicalCheck)
- [`map.sh`](./text.md#mapEnvironment) - Same as [`mapEnvironment`](./text.md#mapEnvironment)
- [`new-release.sh`](./version.md#newRelease) - Same as [`newRelease`](./version.md#newRelease)
- [`release-notes.sh`](./git.md#releaseNotes) - Same as [`releaseNotes`](./git.md#releaseNotes)
- [`version-last.sh`](./git.md#gitVersionLast) - Same as [`gitVersionLast`](./git.md#gitVersionLast)
- [`version-list.sh`](./git.md/#gitVersionList) - Same as [`gitVersionList`](./git.md/#gitVersionList)

## `tools.sh` to run commands

Do `source tools.sh` to load all functions into the current environment.

You can also do

    ./tools.sh decorate file "$(pwd)"

To run commands directly; note this is slower for larger scripts and can be used when a single function is necessary.

## `identical-repair.sh` repair with semantics

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## `install-bin-build.sh`

Modify the last line of this file when installing at a different project depth:

    __installPackageConfiguration ../.. "$@"

The `../..` is the relative path from the script to the project root directory. - [function ]() - []() will do this for you.

### `__installBinBuildURL` - Installs Zesk Build from GitHub

Installs Zesk Build from GitHub

- Location: `bin/build/install-bin-build.sh`

#### Arguments

- `--local localPackageDirectory` - Optional. Directory. Directory of an existing bin/infrastructure installation to mock behavior for testing
- `--user headerText` - Optional. String. Add `username:password` to remote request.
- `--header headerText` - Optional. String. Add one or more headers to the remote request.
- `--debug` - Optional. Flag. Debugging is on.
- `--force` - Optional. Flag. Force installation even if file is up to date.
- `--diff` - Optional. Flag. Show differences between old and new file.
- `--replace` - Optional. Flag. Replace an old version of this script with this one and delete this one. Internal only, do not use.

#### Exit codes

- `1` - Environment error
- `2` - Argument error

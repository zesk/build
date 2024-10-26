# apt Package Manager Tools

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

### `aptIsInstalled` - Is apt-get installed?

Is apt-get installed?

- Location: `bin/build/tools/apt.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## Apt Key Management

### `aptSourcesDirectory` - Get APT source list path

Get APT source list path

- Location: `bin/build/tools/apt.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `aptKeyAdd` - Add keys to enable apt to download terraform directly from

Add keys to enable apt to download terraform directly from hashicorp.com

- Location: `bin/build/tools/apt.sh`

#### Arguments

- `--title title` - Optional. String. Title of the key.
- `--name name` - Required. String. Name of the key used to generate file names.
- `--url remoteUrl` - Required. URL. Remote URL of gpg key.

#### Exit codes

- `1` - if environment is awry
- `0` - Apt key is installed AOK
### `aptKeyRemove` - Remove apt keys

Remove apt keys

- Location: `bin/build/tools/apt.sh`

#### Arguments

- `keyName` - Required. String. One or more key names to remove.

#### Exit codes

- `1` - if environment is awry
- `0` - Apt key is installed AOK
### `aptKeyRingDirectory` - Get key ring directory path

Get key ring directory path

- Location: `bin/build/tools/apt.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## Deprecated October 2024

See (package)[./package.md] functions for replacements.

### `aptUpdateOnce` - Do `apt-get update` once

Run apt-get update once and only once in the pipeline, at least
once an hour as well (when testing)

- Location: `bin/build/tools/apt.sh`

#### Arguments

- `--force` - Optional. Flag. Force apt-update regardless.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

Stores state files in `./.build/` directory which is created if it does not exist.
### `aptInstall` - Install packages using `apt-get`

Install packages using `apt-get`. If `apt-get` is not available, this succeeds
and assumes packages will be available.

Main reason to use this instead of `apt-get` raw is it's quieter.

Also does a simple lookup in the list of installed packages to avoid double-installation.



- Location: `bin/build/tools/apt.sh`

#### Usage

    aptInstall [ package ... ]
    

#### Arguments

- `package` - One or more packages to install

#### Examples

    aptInstall shellcheck

#### Exit codes

- `0` - If `apt-get` is not installed, returns 0.
- `1` - If `apt-get` fails to install the packages
### `aptUninstall` - Uninstall apt packages

Uninstall apt packages

- Location: `bin/build/tools/apt.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `aptNeedRestartFlag` - DEPRECATED

DEPRECATED

- Location: `bin/build/tools/apt.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `whichAptUninstall` - DEPRECATED

DEPRECATED

- Location: `bin/build/tools/apt.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `whichApt` - DEPRECATED

DEPRECATED

- Location: `bin/build/tools/apt.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

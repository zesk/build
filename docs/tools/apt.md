# apt Package Manager Tools

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `aptSourcesDirectory` - Get APT source list path

Get APT source list path

- Location: `bin/build/tools/apt.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
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
### `aptUpToDate` - OS upgrade and potential restart

OS upgrade and potential restart
Progress is written to stderr
Result is `ok` or `restart` written to stdout

- Location: `bin/build/tools/apt.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Failed due to issues with environment
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
### `aptListInstalled` - List installed packages

List installed packages

- Location: `bin/build/tools/apt.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `aptNeedRestartFlag` - INTERNAL - has `aptUpToDate` set the `restart` flag at some

INTERNAL - has `aptUpToDate` set the `restart` flag at some point?

- Location: `bin/build/tools/apt.sh`

#### Arguments

- `value` - Set the restart flag to this value (blank to remove)

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `aptUninstall` - Removes packages using `apt-get`

Removes packages using `apt-get`. If `apt-get` is not available, this succeeds
and assumes packages will be available. (For now)

- Location: `bin/build/tools/apt.sh`

#### Usage

    aptUninstall [ package ... ]
    

#### Arguments

- `package` - One or more packages to install

#### Examples

    aptInstall shellcheck

#### Exit codes

- `0` - If `apt-get` is not installed, returns 0.
- `1` - If `apt-get` fails to remove the packages
### `aptKeyRingDirectory` - Get key ring directory path

Get key ring directory path

- Location: `bin/build/tools/apt.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `aptIsInstalled` - Is apt-get installed?

Is apt-get installed?

- Location: `bin/build/tools/apt.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### `whichApt` - Install tools using `apt-get` if they are not found

Installs an apt package if a binary does not exist in the which path.
The assumption here is that `aptInstallPackage` will install the desired `binary`.

Confirms that `binary` is installed after installation succeeds.

- Location: `bin/build/tools/apt.sh`

#### Arguments

- `binary` - Required. String. The binary to look for
- `aptInstallPackage` - Required. String. The package name to install if the binary is not found in the `$PATH`.

#### Examples

    whichApt shellcheck shellcheck
    whichApt mariadb mariadb-client

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

Technically this will install the binary and any related files as a package.
### `whichAptUninstall` - Install tools using `apt-get` if they are not found

Installs an apt package if a binary does not exist in the `which` path (e.g. `$PATH`)
The assumption here is that `aptUninstall` will install the desired `binary`.

Confirms that `binary` is installed after installation succeeds.

- Location: `bin/build/tools/apt.sh`

#### Arguments

- `binary` - Required. String. The binary to look for.
- `aptInstallPackage` - Required. String. The package name to uninstall if the binary is found in the `$PATH`.

#### Examples

    whichAptUninstall shellcheck shellcheck
    whichAptUninstall mariadb mariadb-client

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

Technically this will uninstall the binary and any related files as a package.

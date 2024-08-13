# apt Package Manager Tools

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

### `aptUpdateOnce` - Do `apt-get update` once

Run apt-get update once and only once in the pipeline, at least
once an hour as well (when testing)

#### Arguments

- `--force` - Optional. Flag. Force apt-update regardless.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

Stores state files in `./.build/` directory which is created if it does not exist.
### `whichApt` - Install tools using `apt-get` if they are not found

Installs an apt package if a binary does not exist in the which path.
The assumption here is that `aptInstallPackage` will install the desired `binary`.

Confirms that `binary` is installed after installation succeeds.

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

Installs an apt package if a binary does not exist in the which path.
The assumption here is that `aptInstallPackage` will install the desired `binary`.

Confirms that `binary` is installed after installation succeeds.

#### Arguments

- `binary` - Required. String. The binary to look for.
- `aptInstallPackage` - The package name to install if the binary is not found in the `$PATH`.

#### Examples

    whichApt shellcheck shellcheck
    whichApt mariadb mariadb-client

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

Technically this will install the binary and any related files as a package.
### `aptInstall` - Install packages using `apt-get`

Install packages using `apt-get`. If `apt-get` is not available, this succeeds
and assumes packages will be available.



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

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Failed due to issues with environment
### `aptKeyAdd` - Add keys to enable apt to download terraform directly from

Add keys to enable apt to download terraform directly from hashicorp.com

#### Arguments

- `--title title` - Optional. String. Title of the key.
- `--name name` - Required. String. Name of the key used to generate file names.
- `--url remoteUrl` - Required. URL. Remote URL of gpg key.

#### Exit codes

- `1` - if environment is awry
- `0` - Apt key is installed AOK
### `aptKeyRemoveHashicorp` - Add keys to enable apt to download terraform directly from

Add keys to enable apt to download terraform directly from hashicorp.com

#### Usage

    aptKeyAddHashicorp
    

#### Arguments

- No arguments.

#### Exit codes

- `1` - if environment is awry
- `0` - All good to install terraform
### `aptKeyRemove` - Remove apt keys

Remove apt keys

#### Arguments

- `keyName` - Required. String. One or more key names to remove.

#### Exit codes

- `1` - if environment is awry
- `0` - Apt key is installed AOK
### `aptListInstalled` - List installed packages

List installed packages

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `aptNeedRestartFlag` - INTERNAL - has `aptUpToDate` set the `restart` flag at some

INTERNAL - has `aptUpToDate` set the `restart` flag at some point?

#### Arguments

- `value` - Set the restart flag to this value (blank to remove)

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `aptUninstall` - Removes packages using `apt-get`

Removes packages using `apt-get`. If `apt-get` is not available, this succeeds
and assumes packages will be available. (For now)

#### Usage

    aptUninstall [ package ... ]
    

#### Arguments

- `package` - One or more packages to install

#### Examples

    aptInstall shellcheck

#### Exit codes

- `0` - If `apt-get` is not installed, returns 0.
- `1` - If `apt-get` fails to remove the packages

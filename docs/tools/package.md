# Package Manager Tools

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

## Conditional installation

### `packageWhich` - Install tools using `apt-get` if they are not found

Installs an apt package if a binary does not exist in the which path.
The assumption here is that `packageInstallPackage` will install the desired `binary`.

Confirms that `binary` is installed after installation succeeds.

- Location: `bin/build/tools/package.sh`

#### Arguments

- `--manager packageManager` - Optional. String. Package manager to use. (apk, apt, brew)
- `binary` - Required. String. The binary to look for
- `packageName ...` - Required. String. The package name to install if the binary is not found in the `$PATH`.

#### Examples

    packageWhich shellcheck shellcheck
    packageWhich mariadb mariadb-client

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

Technically this will install the binary and any related files as a package.
### `packageWhichUninstall` - Install tools using `apt-get` if they are not found

Installs an apt package if a binary does not exist in the `which` path (e.g. `$PATH`)
The assumption here is that `packageUninstall` will install the desired `binary`.

Confirms that `binary` is installed after installation succeeds.

- Location: `bin/build/tools/package.sh`

#### Arguments

- `--manager packageManager` - Optional. String. Package manager to use. (apk, apt, brew)
- `binary` - Required. String. The binary to look for.
- `packageInstallPackage` - Required. String. The package name to uninstall if the binary is found in the `$PATH`.

#### Examples

    packageWhichUninstall shellcheck shellcheck
    packageWhichUninstall mariadb mariadb-client

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

Technically this will uninstall the binary and any related files as a package.

## Package management

### `packageUpdate` - Update packages lists and sources

Update packages lists and sources

- Location: `bin/build/tools/package.sh`

#### Arguments

- `--help` - Optional. Flag. Display this help.
- `--manager packageManager` - Optional. String. Package manager to use. (apk, apt, brew)
- `--force` - Optional. Flag. Force even if it was updated recently.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `packageUpgrade` - Upgrade packages lists and sources

Upgrade packages lists and sources

- Location: `bin/build/tools/package.sh`

#### Arguments

- `--help` - Optional. Flag. Display this help.
- `--manager packageManager` - Optional. String. Package manager to use. (apk, apt, brew)
- `--force` - Optional. Flag. Force even if it was updated recently.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `packageInstall` - Install packages using a package manager

Install packages using a package manager.

Supported managers:
- apk
- apt-get
- brew



- Location: `bin/build/tools/package.sh`

#### Arguments

- `package` - One or more packages to install

#### Examples

    packageInstall shellcheck

#### Exit codes

- `0` - If `apk` is not installed, returns 0.
- `1` - If `apk` fails to install the packages
### `packageUninstall` - Removes packages using package manager

Removes packages using the current package manager.

- Location: `bin/build/tools/package.sh`

#### Arguments

- `package` - One or more packages to uninstall

#### Examples

    packageUninstall shellcheck

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## Package lists

### `packageInstalledList` - List installed packages on this system using package manager

List installed packages on this system using package manager

- Location: `bin/build/tools/package.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `packageAvailableList` - List installed packages on this system using package manager

List installed packages on this system using package manager

- Location: `bin/build/tools/package.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## Package Utilities

### `packageManagerValid` - Is the package manager supported?

Is the package manager supported?

- Location: `bin/build/tools/package.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `packageManagerDefault` - Determine the default manager

Determine the default manager

- Location: `bin/build/tools/package.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `packageNeedRestartFlag` - INTERNAL - has `packageUpdate` set the `restart` flag at some

INTERNAL - has `packageUpdate` set the `restart` flag at some point?

- Location: `bin/build/tools/package.sh`

#### Arguments

- `value` - Set the restart flag to this value (blank to remove)

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

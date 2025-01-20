# Unused functions

Hides these from [New and uncategorized functions](./todo.md)

### `exampleFunction` - This is a sample function with example code and patterns

This is a sample function with example code and patterns used in Zesk Build.

- Location: `bin/build/tools/example.sh`

#### Arguments

- `--help` - Optional. Flag. Display this help.
- `--easy` - Optional. Flag. Easy mode.
- `binary` - Required. String. The binary to look for.
- `remoteUrl` - Required. URL. Remote URL.
- `--target target` - Optional. File. File to create. File must exist.
- `--path path` - Optional. Directory. Directory of path of thing.
- `--title title` - Optional. String. Title of the thing.
- `--name name` - Optional. String. Name of the thing.
- `--url url` - Optional. URL. URL to download.
- `--callable callable` - Optional. Callable. Function to call when url is downloaded.

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
### `packageUninstall` - Removes packages using package manager

Removes packages using the current package manager.

- Location: `bin/build/tools/package.sh`

#### Arguments

- `package` - String. Required. One or more packages to uninstall

#### Examples

    packageUninstall shellcheck

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


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
### `runHookOptional` - Not keeping this around will break old scripts, so don't

Not keeping this around will break old scripts, so don't be a ...

- Location: `bin/build/tools/deprecated.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `runHook` - Not keeping this around will break old scripts, so don't

Not keeping this around will break old scripts, so don't be a ...

- Location: `bin/build/tools/deprecated.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

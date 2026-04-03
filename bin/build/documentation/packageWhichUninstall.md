## `packageWhichUninstall`

> Install tools using `apt-get` if they are not found

### Usage

    packageWhichUninstall [ --manager packageManager ] binary packageInstallPackage

Installs an apt package if a binary does not exist in the `which` path (e.g. `$PATH`)
The assumption here is that `packageUninstall` will install the desired `binary`.
Confirms that `binary` is installed after installation succeeds.

### Arguments

- `--manager packageManager` - String. Optional. Package manager to use. (apk, apt, brew)
- `binary` - String. Required. The binary to look for.
- `packageInstallPackage` - String. Required. The package name to uninstall if the binary is found in the `$PATH`.

### Examples

    packageWhichUninstall mariadb mariadb-client

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Environment

- Technically this will uninstall the binary and any related files as a package.


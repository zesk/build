## `packageWhich`

> Install tools using `apt-get` if they are not found

### Usage

    packageWhich [ --manager packageManager ] binary [ packageName ... ]

Installs an apt package if a binary does not exist in the which path.
The assumption here is that `packageInstallPackage` will install the desired `binary`.
Confirms that `binary` is installed after installation succeeds.

### Arguments

- `--manager packageManager` - String. Optional. Package manager to use. (apk, apt, brew)
- `binary` - String. Required. The binary to look for
- `packageName ...` - String. Optional. The package name to install if the binary is not found in the `$PATH`. If not supplied uses the same name as the binary.

### Examples

    packageWhich mariadb mariadb-client

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Environment

- Technically this will install the binary and any related files as a package.


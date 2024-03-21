# apt Package Manager Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)


### `aptUpdateOnce` - Do `apt-get update` once

Run apt-get update once and only once in the pipeline, at least
once an hour as well (when testing)

#### Usage

    aptUpdateOnce
    

#### Exit codes

- `0` - Always succeeds

#### Environment

Stores state files in `./.build/` directory which is created if it does not exist.

### `whichApt` - Install tools using `apt-get` if they are not found

Installs an apt package if a binary does not exist in the which path.
The assumption here is that `aptInstallPackage` will install the desired `binary`.

Confirms that `binary` is installed after installation succeeds.

#### Arguments

- `binary` - The binary to look for
- `aptInstallPackage` - The package name to install if the binary is not found in the `$PATH`.

#### Examples

    whichApt shellcheck shellcheck
    whichApt mariadb mariadb-client

#### Exit codes

- `0` - Always succeeds

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
Result is `uptodate` or `restart` written to stdout

#### Exit codes

- `0` - Success
- `1` - Failed due to issues with environment

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)

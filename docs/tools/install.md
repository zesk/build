# Installation Functions

Install software as `root` or superuser.

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

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
### `awsInstall` - aws Command-Line install

aws Command-Line install

Installs x86 or aarch64 binary based on `$HOSTTYPE`.



- Location: `bin/build/tools/aws.sh`

#### Arguments

- `package` - One or more packages to install using `apt-get` prior to installing AWS

#### Exit codes

- if `packageInstall` fails, the exit code is returned

#### Depends

    apt-get
    

### `dockerComposeInstall` - Install `docker-compose`

Install `docker-compose`

If this fails it will output the installation log.

When this tool succeeds the `docker-compose` binary is available in the local operating system.

- Location: `bin/build/tools/install.sh`

#### Arguments

- `package` - Additional packages to install (using apt)

#### Exit codes

- `1` - If installation fails
- `0` - If installation succeeds
### `dockerComposeUninstall` - Install `docker-compose`

Install `docker-compose`

If this fails it will output the installation log.

When this tool succeeds the `docker-compose` binary is available in the local operating system.

- Location: `bin/build/tools/install.sh`

#### Arguments

- `package` - Additional packages to install (using apt)

#### Exit codes

- `1` - If installation fails
- `0` - If installation succeeds

### `gitInstall` - Install git if needed

Installs the `git` binary

- Location: `bin/build/tools/git.sh`

#### Arguments

- `package` - Additional packages to install

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `mariadbInstall` - Install `mariadb`

Install `mariadb`

If this fails it will output the installation log.

When this tool succeeds the `mariadb` binary is available in the local operating system.

- Location: `bin/build/tools/install.sh`

#### Arguments

- `package` - Additional packages to install

#### Exit codes

- `1` - If installation fails
- `0` - If installation succeeds

#### Environment

- `BUILD_NPM_VERSION` - String. Default to `latest`. Used to install `npm -i npm@$BUILD_NPM_VERSION` on install.
### `npmInstall` - Install NPM in the build environment

Install NPM in the build environment
If this fails it will output the installation log.
When this tool succeeds the `npm` binary is available in the local operating system.

- Location: `bin/build/tools/npm.sh`

#### Arguments

- No arguments.

#### Exit codes

- `1` - If installation of npm fails
- `0` - If npm is already installed or installed without error

#### Environment

BUILD_NPM_VERSION - Read-only. Default version. If not specified, uses `latest`.
- `BUILD_NPM_VERSION` - String. Default to `latest`. Used to install `npm -i npm@$BUILD_NPM_VERSION` on install.
### `phpInstall` - Install `php`

Install `php`

If this fails it will output the installation log.

When this tool succeeds the `php` binary is available in the local operating system.

- Location: `bin/build/tools/php.sh`

#### Arguments

- `package` - Additional packages to install

#### Exit codes

- `1` - If installation fails
- `0` - If installation succeeds
### `pythonInstall` - Install `python`

Install `python`

If this fails it will output the installation log.

When this tool succeeds the `python` binary is available in the local operating system.

- Location: `bin/build/tools/install.sh`

#### Arguments

- `package` - Additional packages to install

#### Exit codes

- `1` - If installation fails
- `0` - If installation succeeds
### `terraformInstall` - Install terraform binary

Install terraform binary

- Location: `bin/build/tools/terraform.sh`

#### Arguments

- `package` - Additional packages to install using `packageInstall`

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### `gitUninstall` - Uninstall git

Uninstalls the `git` binary

- Location: `bin/build/tools/git.sh`

#### Arguments

- `package` - Additional packages to uninstall

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `mariadbUninstall` - Uninstall mariadb

Uninstall mariadb

- Location: `bin/build/tools/install.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `npmUninstall` - Core as part of some systems - so this succeeds

Core as part of some systems - so this succeeds and it still exists

- Location: `bin/build/tools/npm.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `phpUninstall` - Uninstall `php`

Uninstall `php`

If this fails it will output the installation log.

When this tool succeeds the `php` binary is no longer available in the local operating system.

- Location: `bin/build/tools/php.sh`

#### Arguments

- `package` - Additional packages to install

#### Exit codes

- `1` - If uninstallation fails
- `0` - If uninstallation succeeds
### `pythonUninstall` - Uninstall python

Uninstall python

- Location: `bin/build/tools/install.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `terraformUninstall` - Remove terraform binary

Remove terraform binary

- Location: `bin/build/tools/terraform.sh`

#### Arguments

- `package` - Additional packages to uninstall using `packageUninstall`

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

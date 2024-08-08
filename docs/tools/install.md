# Installation Functions

Install software as `root` or superuser.

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

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
### `awsInstall` - aws Command-Line install

aws Command-Line install

Installs x86 or aarch64 binary based on `$HOSTTYPE`.



#### Usage

    awsInstall [ package ... ]
    

#### Arguments

- `package` - One or more packages to install using `apt-get` prior to installing AWS

#### Exit codes

- if `aptInstall` fails, the exit code is returned

#### Depends

    apt-get
    

### `dockerComposeInstall` - Install `docker-compose`

Install `docker-compose`

If this fails it will output the installation log.

When this tool succeeds the `docker-compose` binary is available in the local operating system.

#### Arguments

- `package` - Additional packages to install (using apt)

#### Exit codes

- `1` - If installation fails
- `0` - If installation succeeds
### `dockerComposeUninstall` - Install `docker-compose`

Install `docker-compose`

If this fails it will output the installation log.

When this tool succeeds the `docker-compose` binary is available in the local operating system.

#### Arguments

- `package` - Additional packages to install (using apt)

#### Exit codes

- `1` - If installation fails
- `0` - If installation succeeds

### `gitInstall` - Install git if needed

Installs the `git` binary

#### Usage

    gitInstall [ package ... ]
    

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

#### Arguments

- No arguments.

#### Exit codes

- `1` - If installation of npm fails
- `0` - If npm is already installed or installed without error

#### Environment

- `BUILD_NPM_VERSION` - String. Default to `latest`. Used to install `npm -i npm@$BUILD_NPM_VERSION` on install.
### `phpInstall` - Install `php`

Install `php`

If this fails it will output the installation log.

When this tool succeeds the `php` binary is available in the local operating system.

#### Arguments

- `package` - Additional packages to install

#### Exit codes

- `1` - If installation fails
- `0` - If installation succeeds
### `prettierInstall` - Install prettier in the build environment

Install prettier in the build environment
If this fails it will output the installation log.
When this tool succeeds the `prettier` binary is available in the local operating system.

#### Usage

    prettierInstall [ npmVersion ]
    

#### Arguments

- `npmVersion` - Optional. String. npm version to install.

#### Exit codes

- `1` - If installation of prettier or npm fails
- `0` - If npm is already installed or installed without error

#### Environment

- `BUILD_NPM_VERSION` - String. Default to `latest`. Used to install `npm -i npm@$BUILD_NPM_VERSION` on install.
### `pythonInstall` - Install `python`

Install `python`

If this fails it will output the installation log.

When this tool succeeds the `python` binary is available in the local operating system.

#### Arguments

- `package` - Additional packages to install

#### Exit codes

- `1` - If installation fails
- `0` - If installation succeeds
### `terraformInstall` - Install terraform binary

Install terraform binary

#### Usage

    terraformInstall [ package ... ]
    

#### Arguments

- `package` - Additional packages to install using `aptInstall`

#### Exit codes

- `1` - Problems
- `0` - Installed successfully

### `gitUninstall` - Uninstall git

Uninstalls the `git` binary

#### Arguments

- `package` - Additional packages to uninstall

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `mariadbUninstall` - Uninstall mariadb

Uninstall mariadb

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `npmUninstall` - Core as part of some systems - so this succeeds

Core as part of some systems - so this succeeds and it still exists

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

#### Arguments

- `package` - Additional packages to install

#### Exit codes

- `1` - If uninstallation fails
- `0` - If uninstallation succeeds
#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `pythonUninstall` - Uninstall python

Uninstall python

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `terraformUninstall` - Remove terraform binary

Remove terraform binary

#### Arguments

- `package` - Additional packages to uninstall using `aptUninstall`

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

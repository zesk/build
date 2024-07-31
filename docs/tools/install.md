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



#### Exit codes

- if `aptInstall` fails, the exit code is returned

#### Depends

    apt-get
    


### `dockerComposeInstall` - Install `docker-compose`

Install `docker-compose`

If this fails it will output the installation log.

When this tool succeeds the `docker-compose` binary is available in the local operating system.

#### Usage

    dockerComposeInstall [ package ... ]
    

#### Arguments



#### Exit codes

- `1` - If installation fails
- `0` - If installation succeeds

### `dockerComposeUninstall` - Install `docker-compose`

Install `docker-compose`

If this fails it will output the installation log.

When this tool succeeds the `docker-compose` binary is available in the local operating system.

#### Usage

    dockerComposeUninstall [ package ... ]
    

#### Arguments



#### Exit codes

- `1` - If installation fails
- `0` - If installation succeeds


### `gitInstall` - Install git if needed

Installs the `git` binary

#### Usage

    gitInstall [ package ... ]
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

### `mariadbInstall` - Install `mariadb`

Install `mariadb`

If this fails it will output the installation log.

When this tool succeeds the `mariadb` binary is available in the local operating system.

#### Usage

    mariadbInstall [ package ]
    mariadbInstall [ package ... ]
    

#### Arguments



#### Exit codes

- `1` - If installation fails
- `0` - If installation succeeds

#### Environment

- `BUILD_NPM_VERSION` - String. Default to `latest`. Used to install `npm -i npm@$BUILD_NPM_VERSION` on install.

### `npmInstall` - Install NPM in the build environment

Install NPM in the build environment
If this fails it will output the installation log.
When this tool succeeds the `npm` binary is available in the local operating system.

#### Usage

    npmInstall npmVersion
    

#### Exit codes

- `1` - If installation of npm fails
- `0` - If npm is already installed or installed without error

#### Environment

- `BUILD_NPM_VERSION` - String. Default to `latest`. Used to install `npm -i npm@$BUILD_NPM_VERSION` on install.

### `phpInstall` - Install `php`

Install `php`

If this fails it will output the installation log.

When this tool succeeds the `php` binary is available in the local operating system.

#### Usage

    phpInstall [ package ... ]
    

#### Arguments



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



#### Exit codes

- `1` - If installation of prettier or npm fails
- `0` - If npm is already installed or installed without error

#### Environment

- `BUILD_NPM_VERSION` - String. Default to `latest`. Used to install `npm -i npm@$BUILD_NPM_VERSION` on install.

### `pythonInstall` - Install `python`

Install `python`

If this fails it will output the installation log.

When this tool succeeds the `python` binary is available in the local operating system.

#### Usage

    pythonInstall [ package ]
    

#### Arguments



#### Exit codes

- `1` - If installation fails
- `0` - If installation succeeds

### `terraformInstall` - Install terraform binary

Install terraform binary

#### Usage

    terraformInstall [ package ... ]
    

#### Arguments



#### Exit codes

- `1` - Problems
- `0` - Installed successfully


### `gitUninstall` - Uninstall git

Uninstalls the `git` binary

#### Usage

    gitUninstall [ package ... ]
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

### `mariadbUninstall` - Uninstall mariadb

Uninstall mariadb

#### Exit codes

- `0` - Always succeeds

### `npmUninstall` - Core as part of some systems - so this succeeds

Core as part of some systems - so this succeeds and it still exists

#### Usage

    npmUninstall
    

#### Exit codes

- `0` - Always succeeds

### `phpUninstall` - Uninstall `php`

Uninstall `php`

If this fails it will output the installation log.

When this tool succeeds the `php` binary is no longer available in the local operating system.

#### Usage

    phpUninstall [ package ... ]
    

#### Arguments



#### Exit codes

- `1` - If uninstallation fails
- `0` - If uninstallation succeeds

#### Exit codes

- `0` - Always succeeds

### `pythonUninstall` - Uninstall python

Uninstall python

#### Exit codes

- `0` - Always succeeds

### `terraformUninstall` - Remove terraform binary

Remove terraform binary

#### Usage

    terraformUninstall [ package ... ]
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

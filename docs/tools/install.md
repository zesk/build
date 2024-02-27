# Installation Functions

Install software as `root` or superuser.

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)


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

#### Usage

    dockerComposeInstall [ package ... ]
    

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

- `0` - Always succeeds

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

When this tool succeeds the `python` binary is available in the local operating system.

#### Usage

    phpInstall [ package ... ]
    

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

#### Usage

    pythonInstall [ package ]
    

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

- `package` - Additional packages to install using `apt`

#### Exit codes

- `1` - Error with environment
- `0` - Installed successfully

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)

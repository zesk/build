# node Functions

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

> Environment variables: `NODE_PACKAGE_MANAGER`

### `nodeInstall` - Install nodejs

Install nodejs

- Location: `bin/build/tools/node.sh`

#### Usage

_mapEnvironment

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `nodeUninstall` - Uninstall nodejs

Uninstall nodejs

- Location: `bin/build/tools/node.sh`

#### Usage

_mapEnvironment

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## node Package Manager Utilities

### `nodePackageManagerInstall` - Installs the selected package manager for node

Installs the selected package manager for node

- Location: `bin/build/tools/node.sh`

#### Usage

_mapEnvironment

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `nodePackageManagerUninstall` - Installs the selected package manager for node

Installs the selected package manager for node

- Location: `bin/build/tools/node.sh`

#### Usage

_mapEnvironment

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `nodePackageManagerValid` - Is the passed node package manager name valid?

Is the passed node package manager name valid?

- Location: `bin/build/tools/node.sh`

#### Usage

_mapEnvironment

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `nodePackageManager` - Run an action using the current node package manager

Run an action using the current node package manager
Provides an abstraction to libraries to support any node package manager.
Optionally will output the current node package manager when no arguments are passed.

- Location: `bin/build/tools/node.sh`

#### Usage

_mapEnvironment

#### Arguments

- `action` - Optional. Action to perform: install run update uninstall
- *- `` - Required. Argument. Passed to the node package manager. Required when action is provided.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## node Package Manager `yarn`

> Environment variables: `BUILD_YARN_VERSION`

### `yarnInstall` - Install yarn in the build environment

Install yarn in the build environment
If this fails it will output the installation log.
When this tool succeeds the `yarn` binary is available in the local operating system.

- Location: `bin/build/tools/yarn.sh`

#### Usage

_mapEnvironment

#### Arguments

- No arguments.

#### Exit codes

- `1` - If installation of yarn fails
- `0` - If yarn is already installed or installed without error

#### Environment

BUILD_YARN_VERSION - Read-only. Default version. If not specified, uses `latest`.
- `BUILD_YARN_VERSION` - String. Default to `latest`.

## node Package Manager `npm`

> Environment variables: `BUILD_NPM_VERSION`

### `npmInstall` - Install NPM in the build environment

Install NPM in the build environment
If this fails it will output the installation log.
When this tool succeeds the `npm` binary is available in the local operating system.

- Location: `bin/build/tools/npm.sh`

#### Usage

_mapEnvironment

#### Arguments

- No arguments.

#### Exit codes

- `1` - If installation of npm fails
- `0` - If npm is already installed or installed without error

#### Environment

BUILD_NPM_VERSION - Read-only. Default version. If not specified, uses `latest`.
- `BUILD_NPM_VERSION` - String. Default to `latest`. Used to install `npm -i npm@$BUILD_NPM_VERSION` on install.

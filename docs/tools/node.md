# node Functions

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

### `nodeInstall` - Install nodejs

Install nodejs

- Location: `bin/build/tools/node.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `nodePackageManagerInstall` - Installs the selected package manager for node

Installs the selected package manager for node

- Location: `bin/build/tools/node.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `nodePackageManagerUninstall` - Installs the selected package manager for node

Installs the selected package manager for node

- Location: `bin/build/tools/node.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `nodePackageManagerValid` - undocumented

No documentation for `nodePackageManagerValid`.

- Location: `bin/build/tools/node.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `nodePackageManager` - undocumented

No documentation for `nodePackageManager`.

- Location: `bin/build/tools/node.sh`

#### Arguments

- `action` - Optional. Action to perform: install run update uninstall
- *- `` - Required. Argument. Passed to the node package manager

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `nodeUninstall` - Uninstall nodejs

Uninstall nodejs

- Location: `bin/build/tools/node.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## node Package Manager `yarn`

### `yarnInstall` - Install yarn in the build environment

Install yarn in the build environment
If this fails it will output the installation log.
When this tool succeeds the `yarn` binary is available in the local operating system.

- Location: `bin/build/tools/yarn.sh`

#### Arguments

- No arguments.

#### Exit codes

- `1` - If installation of yarn fails
- `0` - If yarn is already installed or installed without error

#### Environment

- `BUILD_YARN_VERSION` - String. Default to `latest`.

## node Package Manager `npm`

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

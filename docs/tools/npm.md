# npm Functions

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

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

- `BUILD_NPM_VERSION` - String. Default to `latest`. Used to install `npm -i npm@$BUILD_NPM_VERSION` on install.

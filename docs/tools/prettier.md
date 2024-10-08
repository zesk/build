# Prettier functions

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

### `prettierInstall` - Install prettier in the build environment

Install prettier in the build environment
If this fails it will output the installation log.
When this tool succeeds the `prettier` binary is available in the local operating system.

- Location: `bin/build/tools/prettier.sh`

#### Usage

    prettierInstall [ npmVersion ]
    

#### Arguments

- `npmVersion` - Optional. String. npm version to install.

#### Exit codes

- `1` - If installation of prettier or npm fails
- `0` - If npm is already installed or installed without error

#### Environment

- `BUILD_NPM_VERSION` - String. Default to `latest`. Used to install `npm -i npm@$BUILD_NPM_VERSION` on install.

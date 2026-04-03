## `npmInstall`

> Install NPM in the build environment

### Usage

    npmInstall [ --version versionCode ]

Install NPM in the build environment
If this fails it will output the installation log.
When this tool succeeds the `npm` binary is available in the local operating system.

### Arguments

- `--version versionCode` - String. Optional. Install this version of python.

### Return codes

- `1` - If installation of npm fails
- `0` - If npm is already installed or installed without error

### Environment

- {SEE:BUILD_NPM_VERSION.sh} - Read-only. Default version. If not specified, uses `latest`.
- - `BUILD_NPM_VERSION` - String. Default to `latest`. Used to install `npm -i npm@$BUILD_NPM_VERSION` on install.


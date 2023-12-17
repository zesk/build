
# `npmInstall` - Install NPM in the build environment

[⬅ Return to top](index.md)

Install NPM in the build environment
If this fails it will output the installation log.
When this tool succeeds the `npm` binary is available in the local operating system.

## Usage

    npmInstall npmVersion

## Exit codes

- `1` - If installation of npm fails
- `0` - If npm is already installed or installed without error

## Environment

- `BUILD_NPM_VERSION` - String. Default to `latest`. Used to install `npm -i npm@$BUILD_NPM_VERSION` on install.

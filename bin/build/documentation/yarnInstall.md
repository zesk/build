## `yarnInstall`

> Install yarn in the build environment

### Usage

    yarnInstall [ --version versionCode ] [ --help ]

Install yarn in the build environment
If this fails it will output the installation log.
When this tool succeeds the `yarn` binary is available in the local operating system.

### Arguments

- `--version versionCode` - String. Optional. Install this version of yarn. Defaults to `stable` if `BUILD_YARN_VERSION` is blank or unset.
- `--help` - Flag. Optional. Display this help.

### Return codes

- `1` - If installation of yarn fails
- `0` - If yarn is already installed or installed without error

### Environment

- - BUILD_YARN_VERSION


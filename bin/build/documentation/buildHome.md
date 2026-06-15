### `buildHome`

> Prints the build home directory (usually same as the application

#### Usage

    buildHome [ --help ]

Prints the build home directory (usually same as the application root)

> Location: `bin/build/tools/build.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

- [`BUILD_HOME` Build Home Directory]({rel}env/#build_configuration) – **Directory**. `BUILD_HOME` is `.` when this code is installed - at


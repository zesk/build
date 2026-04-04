## `consoleHasColors`

> Sets the environment variable `BUILD_COLORS` if not set, uses `TERM`

### Usage

    consoleHasColors [ --help ]

Sets the environment variable `BUILD_COLORS` if not set, uses `TERM` to calculate

### Arguments

- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - Console or output supports colors
- `1` - Colors are likely not supported by console

### Environment

- {SEE:BUILD_COLORS.sh} - Boolean. Optional. Whether the build system will output ANSI colors.

### Requires

isPositiveInteger tput __help convertValue


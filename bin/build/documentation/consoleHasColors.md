### `consoleHasColors`

> Sets the environment variable `BUILD_COLORS` if not set, uses `TERM`

#### Usage

    consoleHasColors [ --help ]

Sets the environment variable `BUILD_COLORS` if not set, uses `TERM` to calculate

> Location: `bin/build/tools/decorate/core.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.

#### Return codes

- `0` - Console or output supports colors
- `1` - Colors are likely not supported by console

#### Environment

- [`BUILD_COLORS` Build Colors Flag]({rel}env/#decoration) – **Boolean**. If true then colors are shown, blank means guess the - Boolean. Optional. Whether the build system will output ANSI colors.

#### Requires

- [isPositiveInteger]({rel}tools/type.md#ispositiveinteger) - Test if an argument is a positive integer (non-zero) ([source](https://github.com/zesk/build/blob/main/bin/build/tools/type.sh#L153))tput


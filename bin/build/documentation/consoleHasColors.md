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

- {SEE:BUILD_COLORS} - Boolean. Optional. Whether the build system will output ANSI colors.

#### Requires

- [isPositiveInteger]({rel}tools/type.md#ispositiveinteger) - Test if an argument is a positive integer (non-zero) ([source](https://github.com/zesk/build/blob/main/bin/build/tools/type.sh#L153))
- [`tput`]({rel}guide/command.md#tput)
- [helpArgument]({rel}tools/argument.md#helpargument) - Simple help argument handler. ([source](https://github.com/zesk/build/blob/main/bin/build/tools/argument.sh#L576))
- [convertValue]({rel}tools/sugar-core.md#convertvalue) - map a value from one value to another given from-to ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L161))


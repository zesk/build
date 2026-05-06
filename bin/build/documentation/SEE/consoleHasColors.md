## `consoleHasColors`

> Sets the environment variable `BUILD_COLORS` if not set, uses `TERM`

### Usage

    consoleHasColors [ --help ]

Sets the environment variable `BUILD_COLORS` if not set, uses `TERM` to calculate

> Location: `bin/build/tools/decorate/core.sh`

### Arguments

- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - Console or output supports colors
- `1` - Colors are likely not supported by console

### Requires

- {SEE:isPositiveInteger}
- tput
- {SEE:helpArgument}
- {SEE:convertValue}


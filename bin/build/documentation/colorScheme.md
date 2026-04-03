## `colorScheme`

> Set the terminal color scheme to the specification

### Usage

    colorScheme [ --help ] [ --handler handler ] [ --debug ]

Set the terminal color scheme to the specification

### Arguments

- `--help` - Flag. Optional. Display this help.
- `--handler handler` - Function. Optional. Use this error handler instead of the default error handler.
- `--debug` - Flag. Optional. Show additional debugging information.

### Reads standard input

Scheme definition with `colorName=colorValue` on each line

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


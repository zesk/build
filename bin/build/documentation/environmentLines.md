## `environmentLines`

> List lines of environment values set in a bash state

### Usage

    environmentLines [ --help ]

List lines of environment values set in a bash state file

### Arguments

- `--help` - Flag. Optional. Display this help.

### Examples

    environmentLines < "$stateFile"

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


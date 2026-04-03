## `environmentNames`

> List names of environment values set in a bash state

### Usage

    environmentNames [ --help ]

List names of environment values set in a bash state file

### Arguments

- `--help` - Flag. Optional. Display this help.

### Examples

    environmentNames < "$stateFile"

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


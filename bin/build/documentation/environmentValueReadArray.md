## `environmentValueReadArray`

> Read an array value from a state file

### Usage

    environmentValueReadArray stateFile name [ --help ]

Read an array value from a state file
Outputs array elements, one per line.

### Arguments

- `stateFile` - File. Required. File to access, must exist.
- `name` - EnvironmentVariable. Required. Name to read.
- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


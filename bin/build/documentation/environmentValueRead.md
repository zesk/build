## `environmentValueRead`

> undocumented

### Usage

    environmentValueRead stateFile name [ default ] [ --help ]

No documentation for `environmentValueRead`.

### Arguments

- `stateFile` - EnvironmentFile. Required. File to read a value from.
- `name` - EnvironmentVariable. Required. Variable to read.
- `default` - EmptyString. Optional. Default value of the environment variable if it does not exist.
- `--help` - Flag. Optional. Display this help.

### Return codes

- `1` - If value is not found and no default argument is supplied (2 arguments)
- `0` - If value


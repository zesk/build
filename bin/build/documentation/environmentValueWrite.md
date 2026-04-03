## `environmentValueWrite`

> Write a value to a state file as NAME="value"

### Usage

    environmentValueWrite name [ value ] [ ... ] [ --help ]

Write a value to a state file as NAME="value"

### Arguments

- `name` - String. Required. Name to write.
- `value` - EmptyString. Optional. Value to write.
- `...` - EmptyString. Optional. Additional values, when supplied, write this value as an array.
- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


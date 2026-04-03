## `environmentValueConvertArray`

> Convert an array value which was loaded already

### Usage

    environmentValueConvertArray encodedValue [ --help ]

Convert an array value which was loaded already

### Arguments

- `encodedValue` - String. Required. Value to convert to tokens, one per line
- `--help` - Flag. Optional. Display this help.

### Writes to standard output

Array values separated by newlines

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


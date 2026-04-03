## `convertValue`

> map a value from one value to another given from-to

### Usage

    convertValue [ --help ] [ value ] [ from ] [ to ] [ ... ]

map a value from one value to another given from-to pairs
Prints the mapped value to stdout

### Arguments

- `--help` - Flag. Optional. Display this help.
- `value` - String. A value.
- `from` - String. When value matches `from`, instead print `to`
- `to` - String. The value to print when `from` matches `value`
- `...` - String. Optional. Additional from-to pairs can be passed, first matching value is used, all values will be examined if none match

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


## `returnMap`

> map a return value from one value to another

### Usage

    returnMap [ --help ] [ value ] [ from ] [ to ] [ ... ]

map a return value from one value to another

### Arguments

- `--help` - Flag. Optional. Display this help.
- `value` - Integer. A return value.
- `from` - Integer. When value matches `from`, instead return `to`
- `to` - Integer. The value to return when `from` matches `value`
- `...` - Additional from-to pairs can be passed, first matching value is used, all values will be examined if none match

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


## `mockEnvironmentStart`

> Fake a value for testing

### Usage

    mockEnvironmentStart globalName [ value ] [ ... ] [ --help ]

Fake a value for testing

### Arguments

- `globalName` - EnvironmentVariable. Required. Global to change temporarily to a value.
- `value` - EmptyString. Optional. Force the value of `globalName` to this value temporarily. Saves the original value.
- `...` - Continue passing pairs of globalName value to mock additional values.
- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


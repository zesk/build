## `dateValid`

> Is a date valid?

### Usage

    dateValid [ --help ] [ -- ] text

Is a date valid?

### Arguments

- `--help` - Flag. Optional. Display this help.
- `--` - Flag. Optional. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning.
- `text` - String. Required. Text to validate as a date after the year 1600. Does not validate month and day combinations.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


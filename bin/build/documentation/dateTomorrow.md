## `dateTomorrow`

> Tomorrow's date in UTC

### Usage

    dateTomorrow [ --local ] [ --help ]

Returns tomorrow's date (UTC time), in YYYY-MM-DD format. (same as `%F`)

### Arguments

- `--local` - Flag. Optional. Local tomorrow
- `--help` - Flag. Optional. Display this help.

### Examples

    rotated="$log.$(dateTomorrow)"

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


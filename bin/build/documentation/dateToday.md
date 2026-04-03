## `dateToday`

> Today's date in UTC

### Usage

    dateToday [ --local ] [ --help ]

Returns the current date, in YYYY-MM-DD format. (same as `%F`)

### Arguments

- `--local` - Flag. Optional. Local today.
- `--help` - Flag. Optional. Display this help.

### Examples

    date="$(dateToday)"

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Environment

- Compatible with BSD and GNU date.


## `dateToTimestamp`

> Converts a date to an integer timestamp

### Usage

    dateToTimestamp [ date ] [ --help ]

Converts a date to an integer timestamp

### Arguments

- `date` - String in the form `YYYY-MM-DD` (e.g. `2023-10-15`)
- `--help` - Flag. Optional. Display this help.

### Examples

    timestamp=$(dateToTimestamp '2023-10-15')

### Return codes

- `1` - if parsing fails
- `0` - if parsing succeeds

### Environment

- Compatible with BSD and GNU date.


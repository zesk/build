## `dateToFormat`

> Platform agnostic date conversion

### Usage

    dateToFormat date [ format ]

Converts a date (`YYYY-MM-DD`) to another format.
Compatible with BSD and GNU date.

### Arguments

- `date` - String. Required. String in the form `YYYY-MM-DD` (e.g. `2023-10-15`)
- `format` - String. Optional. Format string for the `date` command (e.g. `%s`)

### Examples

    dateToFormat 2023-04-20 %s 1681948800
    timestamp=$(dateToFormat '2023-10-15' %s)

### Return codes

- `1` - if parsing fails
- `0` - if parsing succeeds


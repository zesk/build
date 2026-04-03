## `dateFromTimestamp`

> Converts an integer date to a date formatted timestamp (e.g.

### Usage

    dateFromTimestamp integerTimestamp [ format ] [ --help ] [ --local ]

Converts an integer date to a date formatted timestamp (e.g. %Y-%m-%d %H:%M:%S)
dateFromTimestamp 1681966800 %F

### Arguments

- `integerTimestamp` - Integer. Required. Integer timestamp offset (unix timestamp, same as `$(date +%s)`)
- `format` - String. Optional. How to output the date (e.g. `%F` - no `+` is required)
- `--help` - Flag. Optional. Display this help.
- `--local` - Flag. Optional. Show the local time, not UTC.

### Examples

    dateField=$(dateFromTimestamp $init %Y)

### Return codes

- `0` - If parsing is successful
- `1` - If parsing fails

### Environment

- Compatible with BSD and GNU date.


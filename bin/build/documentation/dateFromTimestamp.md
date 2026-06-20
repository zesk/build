### `dateFromTimestamp`

> Converts an integer date to a date formatted timestamp (e.g.

#### Usage

    dateFromTimestamp integerTimestamp [ format ] [ --help ] [ --local ]

Converts an integer date to a date formatted timestamp (e.g. `%Y-%m-%d %H:%M:%S`)

> Location: `bin/build/tools/date.sh`

#### Arguments

- `integerTimestamp` - Integer. Required. Integer. Required. Integer timestamp offset (Seconds since 1/1/1970 UTC, same as `$(date +%s)`)
- `format` - String. Optional. How to output the date (e.g. `%F` - no `+` is required)
- `--help` - Flag. Optional. Display this help.
- `--local` - Flag. Optional. Show the local time, not UTC.

#### Examples

    dateFromTimestamp 1681966800 %F
    dateField=$(dateFromTimestamp $init %Y)

#### Return codes

- `0` - If parsing is successful
- `1` - If parsing fails

#### Environment

- Compatible with BSD and GNU date.

#### Requires

- [throwArgument]({rel}tools/sugar-core.md#throwargument) - Run \`handler\` with an argument error ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L215))
- [decorate]({rel}tools/decorate.md#decorate) - decorate text using colors and styles ([source](https://github.com/zesk/build/blob/main/bin/build/tools/decorate/core.sh#L144))
- [validate]({rel}tools/validate.md#validate) - Validate a value by type ([source](https://github.com/zesk/build/blob/main/bin/build/tools/validate.sh#L95))
- [bashDocumentation]({rel}tools/documentation.md#bashdocumentation) - Universal function documentation ([source](https://github.com/zesk/build/blob/main/bin/build/tools/usage.sh#L59))


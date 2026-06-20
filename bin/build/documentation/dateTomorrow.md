### `dateTomorrow`

> Tomorrow's date in UTC

#### Usage

    dateTomorrow [ --local ] [ --help ]

Returns tomorrow's date (UTC time), in `YYYY-MM-DD` format. (same as `%F`)

> Location: `bin/build/tools/date.sh`

#### Arguments

- `--local` - Flag. Optional. Local tomorrow
- `--help` - Flag. Optional. Display this help.

#### Examples

    rotated="$log.$(dateTomorrow)"

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Requires

- {SEE:throwArgument}
- [`date`]({rel}guide/command.md#date)
- [convertValue]({rel}tools/sugar-core.md#convertvalue) - map a value from one value to another given from-to ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L161))
- [dateFromTimestamp]({rel}tools/date.md#datefromtimestamp) - Converts an integer date to a date formatted timestamp (e.g. ([source](https://github.com/zesk/build/blob/main/bin/build/tools/date.sh#L75))
- [bashDocumentation]({rel}tools/documentation.md#bashdocumentation) - Universal function documentation ([source](https://github.com/zesk/build/blob/main/bin/build/tools/usage.sh#L59))


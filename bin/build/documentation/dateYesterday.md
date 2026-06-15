### `dateYesterday`

> Yesterday's date (UTC time)

#### Usage

    dateYesterday [ --local ] [ --help ]

Returns yesterday's date, in `YYYY-MM-DD` format. (same as `%F`)

> Location: `bin/build/tools/date.sh`

#### Arguments

- `--local` - Flag. Optional. Local yesterday
- `--help` - Flag. Optional. Display this help.

#### Examples

    rotated="$log.$(dateYesterday --local)"

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Requires

- [throwArgument]({rel}tools/sugar-core.md#throwargument) - Run \`handler\` with an argument error ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L215))date


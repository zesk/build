# Date Tools

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

### `dateToFormat` - Platform agnostic date conversion

Converts a date (`YYYY-MM-DD`) to another format.

- Location: `bin/build/tools/date.sh`

#### Usage

    dateToFormat date format
    

#### Arguments

- `date` - String in the form `YYYY-MM-DD` (e.g. `2023-10-15`)
- `format` - Format string for the `date` command (e.g. `%s`)

#### Examples

    dateToFormat 2023-04-20 %s 1681948800
    timestamp=$(dateToFormat '2023-10-15' %s)

#### Exit codes

- `1` - if parsing fails
- `0` - if parsing succeeds

#### Environment

Compatible with BSD and GNU date.
### `dateToTimestamp` - Converts a date to an integer timestamp

Converts a date to an integer timestamp

- Location: `bin/build/tools/date.sh`

#### Usage

    dateToTimestamp date
    

#### Arguments

- `date` - String in the form `YYYY-MM-DD` (e.g. `2023-10-15`)

#### Examples

    timestamp=$(dateToTimestamp '2023-10-15')

#### Exit codes

- `1` - if parsing fails
- `0` - if parsing succeeds

#### Environment

Compatible with BSD and GNU date.
### `timestampToDate` - timestampToDate 1681966800 %F

timestampToDate 1681966800 %F

- Location: `bin/build/tools/date.sh`

#### Usage

    timestampToDate integerTimestamp format
    

#### Arguments

- `integerTimestamp` - Integer timestamp offset (unix timestamp, same as `$(date +%s)`)
- `format` - How to output the date (e.g. `%F` - no `+` is required)

#### Examples

    dateField=$(timestampToDate $init %Y)

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

Compatible with BSD and GNU date.
### `todayDate` - Today's date

Returns the current date, in YYYY-MM-DD format. (same as `%F`)

- Location: `bin/build/tools/date.sh`

#### Arguments

- None.

#### Examples

    date="$(todayDate)"

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

Compatible with BSD and GNU date.
### `yesterdayDate` - Yesterday's date

Returns yesterday's date, in YYYY-MM-DD format. (same as `%F`)

- Location: `bin/build/tools/date.sh`

#### Arguments

- No arguments.

#### Examples

    rotated="$log.$(yesterdayDate)"

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `tomorrowDate` - Tomorrow's date

Returns tomorrow's date, in YYYY-MM-DD format. (same as `%F`)

- Location: `bin/build/tools/date.sh`

#### Arguments

- No arguments.

#### Examples

    rotated="$log.$(tomorrowDate)"

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

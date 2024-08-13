# Date Tools

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `dateToTimestamp` - Converts a date to an integer timestamp

Converts a date to an integer timestamp

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
#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `todayDate` - Today's date

Returns the current date, in YYYY-MM-DD format. (same as `%F`)

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
#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

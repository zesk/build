# Date Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)


#### Exit codes

- `0` - Always succeeds

### `dateToTimestamp` - Converts a date to an integer timestamp

Converts a date to an integer timestamp

#### Usage

    dateToTimestamp date
    

#### Arguments



#### Examples

    timestamp=$(dateToTimestamp '2023-10-15')

#### Exit codes

- `1` - if parsing fails
- `0` - if parsing succeeds

#### Environment

Compatible with BSD and GNU date.

#### Exit codes

- `0` - Always succeeds

### `todayDate` - Today's date

Returns the current date, in YYYY-MM-DD format. (same as `%F`)

#### Usage

    todayDate
    

#### Arguments



#### Examples

    date="$(todayDate)"

#### Exit codes

- `0` - Always succeeds

#### Environment

Compatible with BSD and GNU date.

#### Exit codes

- `0` - Always succeeds

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)

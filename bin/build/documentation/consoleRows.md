## `consoleRows`

> Row count in current console

### Usage

    consoleRows [ --help ]

Output the number of columns in the terminal. Default is 60 if not able to be determined from `TERM`.

### Arguments

- `--help` - Flag. Optional. Display this help.

### Examples

    tail -n $(consoleRows) "$file"

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Environment

- - `COLUMNS` - May be defined after calling this
- - `LINES` - May be defined after calling this


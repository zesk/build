## `consoleColumns`

> Column count in current console

### Usage

    consoleColumns [ --help ]

Output the number of columns in the terminal. Default is 80 if not able to be determined from `TERM`.

### Arguments

- `--help` - Flag. Optional. Display this help.

### Writes to standard output

Integer

### Examples

    textRepeat $(consoleColumns)

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Environment

- - `COLUMNS` - May be defined after calling this
- - `LINES` - May be defined after calling this


### `consoleRows`

> Row count in current console

#### Usage

    consoleRows [ --help ]

Output the number of columns in the terminal. Default is 60 if not able to be determined from `TERM`.

`COLUMNS` and `LINES` environment variables may be modified by calling this function.

> Location: `bin/build/tools/colors.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.

#### Examples

    tail -n $(consoleRows) "$file"

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

- COLUMNS LINES

#### See Also

- [`stty`]({rel}guide/command.md#stty)


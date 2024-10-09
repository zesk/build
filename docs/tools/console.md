# Console Tools

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

### `consoleGetColor` - Get the RGB color of the terminal (usually for background

Get the RGB color of the terminal (usually for background colors)

- Location: `bin/build/tools/console.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `consoleConfigureColorMode` - Print the suggested color mode for the current environment

Print the suggested color mode for the current environment

- Location: `bin/build/tools/console.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `consoleColumns` - Column count in current console

Column count in current console

Output the number of columns in the terminal. Default is 80 if not able to be determined from `TERM`.

- Location: `bin/build/tools/colors.sh`

#### Usage

    consoleColumns
    

#### Arguments

- No arguments.

#### Examples

    repeat $(consoleColumns)

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

COLUMNS - May be defined after calling this
LINES - May be defined after calling this
### `consoleRows` - Row count in current console

Row count in current console

Output the number of columns in the terminal. Default is 60 if not able to be determined from `TERM`.

- Location: `bin/build/tools/colors.sh`

#### Usage

    consoleColumns
    

#### Arguments

- No arguments.

#### Examples

    tail -n $(consoleRows) "$file"

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

COLUMNS - May be defined after calling this
LINES - May be defined after calling this
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
#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

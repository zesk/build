## `textSingleBlankLines`

> Ensures blank lines are singular

### Usage

    textSingleBlankLines [ --help ]

Ensures blank lines are singular
Used often to clean up markdown `.md` files, but can be used for any line-based configuration file which allows blank lines.

### Arguments

- `--help` - Flag. Optional. Display this help.

### Reads standard input

Reads lines from stdin until EOF

### Writes to standard output

Outputs modified lines where any blank lines are replaced with a single blank line.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


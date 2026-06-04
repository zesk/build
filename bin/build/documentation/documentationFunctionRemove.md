### `documentationFunctionRemove`

> Remove a function from the documentation cache

#### Usage

    documentationFunctionRemove [ --verbose ] [ --dry-run ] [ --git ] [ --help ]

Remove a function from the documentation cache

> Location: `bin/build/tools/documentation.sh`

#### Arguments

- `--verbose` - Flag. Optional. Use more words or phrases than absolutely essential.
- `--dry-run` - Flag. Optional. Do not do any thing, just say what would be done.
- `--git` - Flag. Remove from git.
- `--help` - Flag. Optional. Display this help.

#### Reads standard input

functionName - File with function names one per line.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


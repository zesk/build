## `environmentParseVariables`

> Parse variables from an environment variable stream

### Usage

    environmentParseVariables [ --help ]

Parse variables from an environment variable stream
Extracts lines with `NAME=value`
Details:
- Remove `export ` from lines
- Skip lines containing `read -r`
- Anything before a `=` is considered a variable name
- Returns a sorted, unique list

### Arguments

- `--help` - Flag. Optional. Display this help.

### Reads standard input

Environment File

### Writes to standard output

EnvironmentVariable. One per line.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


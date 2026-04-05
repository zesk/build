## `bashCommentVariable`

> Gets a list of the variable values from a bash

### Usage

    bashCommentVariable variableName [ --prefix ] [ --insensitive | -i ] [ --help ]

Gets a list of the variable values from a bash function comment

### Arguments

- `variableName` - String. Required. Get this variable value.
- `--prefix` - Flag. Optional. Find variables with the prefix `variableName`
--insensitive |- ` -i` - Flag. Optional. Match case insensitive.
- `--help` - Flag. Optional. Display this help.

### Reads standard input

Comment source (`# ` removed)

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


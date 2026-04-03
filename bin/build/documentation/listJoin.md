## `listJoin`

> Output a list of items joined by a character

### Usage

    listJoin separator [ text0 ... ] [ --help ]

Output a list of items joined by a character

### Arguments

- `separator` - EmptyString. Required. Single character to join elements. If a multi-character string is used only the first character is used as the delimiter.
- `text0 ...` - String. Optional. One or more strings to join
- `--help` - Flag. Optional. Display this help.

### Sample Output

text

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


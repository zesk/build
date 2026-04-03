## `textTrimLeft`

> Trim whitespace of a bash argument

### Usage

    textTrimLeft [ text ]

Trim spaces and only spaces from the left side of a string passed as arguments or a pipe

### Arguments

- `text` - EmptyString. Optional. Text to remove spaces. If no arguments are supplied it is assumed that input should be read from standard input.

### Reads standard input

Reads lines from stdin until EOF

### Writes to standard output

Outputs trimmed lines

### Examples

    textTrimLeft "$token"
    grep "$tokenPattern" | textTrimLeft > "$tokensFound"

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


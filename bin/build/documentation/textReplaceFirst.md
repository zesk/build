## `textReplaceFirst`

> Replaces the first and only the first occurrence of a

### Usage

    textReplaceFirst [ searchString ] [ replaceString ]

Replaces the first and only the first occurrence of a pattern in a line with a replacement string.
Without arguments, displays help.

### Arguments

- `searchString` - String. Thing to search for.
- `replaceString` - String. Thing to replace search string with.

### Reads standard input

Reads lines from stdin until EOF

### Writes to standard output

Outputs modified lines

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


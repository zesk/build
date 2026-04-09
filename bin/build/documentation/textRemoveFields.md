## `textRemoveFields`

> Remove fields from left to right from a text file

### Usage

    textRemoveFields [ fieldCount ]

Remove fields from left to right from a text file as a pipe

### Arguments

- `fieldCount` - Integer. Optional. Number of field to remove. Default is just first `1`.

### Reads standard input

A file with fields separated by spaces

### Writes to standard output

The same file with the first `fieldCount` fields removed from each line.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


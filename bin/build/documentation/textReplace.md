## `textReplace`

> Replace all occurrences of a string within another string

### Usage

    textReplace needle [ replacement ] [ haystack ]

Replace all occurrences of a string within another string

### Arguments

- `needle` - String. Required. String to replace.
- `replacement` - EmptyString.  String to replace needle with.
- `haystack` - EmptyString. Optional. String to modify. If not supplied, reads from standard input.

### Reads standard input

If no haystack supplied reads from standard input and replaces the string on each line read.

### Writes to standard output

New string with needle replaced

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


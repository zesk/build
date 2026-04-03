## `consoleTrimWidth`

> Truncate console output width

### Usage

    consoleTrimWidth width [ text ]

Truncate console output width

### Arguments

- `width` - UnsignedInteger. Required. Width to maintain.
- `text` - String. Optional. Text to trim to a console width.

### Reads standard input

String. Optional. Text to trim to a console width.

### Writes to standard output

String. Console string trimmed to the width requested.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


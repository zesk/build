## `consolePlainLength`

> Length of an unformatted string

### Usage

    consolePlainLength [ text ]

Length of an unformatted string

### Arguments

- `text` - EmptyString. Optional. text to determine the plaintext length of. If not supplied reads from standard input.

### Reads standard input

A file to determine the plain-text length

### Writes to standard output

`UnsignedInteger`. Length of the plain characters in the input arguments.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


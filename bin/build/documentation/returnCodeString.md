## `returnCodeString`

> Output the exit code as a string

### Usage

    returnCodeString [ code ... ] [ --help ]

Output the exit code as a string

### Arguments

- `code ...` - UnsignedInteger. String. Exit code value to output.
- `--help` - Flag. Optional. Display this help.

### Writes to standard output

exitCodeToken, one per line

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


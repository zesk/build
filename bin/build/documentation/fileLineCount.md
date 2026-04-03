## `fileLineCount`

> Outputs the number of lines read from stdin (or supplied

### Usage

    fileLineCount [ --help ] [ --handler handler ] [ file ]

Outputs the number of lines read from stdin (or supplied files) until EOF. For multiple files passed on the command line - each one is output separately.
This is essentially a wrapper around `wc -l` which strips whitespace and does type checking.

### Arguments

- `--help` - Flag. Optional. Display this help.
- `--handler handler` - Function. Optional. Use this error handler instead of the default error handler.
- `file` - File. Optional. Output line count for each file specified. If no files specified, uses stdin.

### Reads standard input

Lines are read from standard in and counted

### Writes to standard output

UnsignedInteger
`UnsignedInteger`

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


## `dumpFile`

> Output a file for debugging

### Usage

    dumpFile [ fileName0 ] [ --symbol symbolString ] [ --lines lineCount ] [ --help ]

Output a file for debugging

### Arguments

- `fileName0` - File. Optional. File to dump.
- `--symbol symbolString` - String. Optional. Prefix for each output line.
- `--lines lineCount` - PositiveInteger. Optional. Number of lines to output.
- `--help` - Flag. Optional. Display this help.

### Reads standard input

text (optional)

### Writes to standard output

formatted text (optional)

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


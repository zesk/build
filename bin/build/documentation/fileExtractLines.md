## `fileExtractLines`

> Extract a range of lines from a file

### Usage

    fileExtractLines startLine endLine [ --help ]

Extract a range of lines from a file

### Arguments

- `startLine` - Integer. Required. Starting line number.
- `endLine` - Integer. Required. Ending line number.
- `--help` - Flag. Optional. Display this help.

### Reads standard input

Reads lines until EOF

### Writes to standard output

Outputs the selected lines only

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


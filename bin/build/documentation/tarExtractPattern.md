## `tarExtractPattern`

> Platform agnostic tar extract with wildcards

### Usage

    tarExtractPattern [ pattern ]

Platform agnostic tar extract with wildcards
e.g. `tar -xf '*/file.json'` or `tar -xf --wildcards '*/file.json'` depending on OS
`tar` command is not cross-platform so this differentiates between the GNU and BSD command line arguments.

### Arguments

- `pattern` - The file pattern to extract

### Reads standard input

A gzipped-tar file

### Writes to standard output

The desired file

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


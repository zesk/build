## `environmentFileToBashCompatible`

> Takes any environment file and makes it bash-compatible

### Usage

    environmentFileToBashCompatible [ filename ... ]

Takes any environment file and makes it bash-compatible
Outputs the compatible env to stdout

### Arguments

- `filename ...` - File. Optional. One or more files to convert.

### Reads standard input

environment file

### Writes to standard output

bash-compatible environment statements

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


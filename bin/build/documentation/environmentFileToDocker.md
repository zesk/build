## `environmentFileToDocker`

> Takes any environment file and makes it docker-compatible

### Usage

    environmentFileToDocker envFile ...

Takes any environment file and makes it docker-compatible

Outputs the compatible env to stdout

> Location: `bin/build/tools/environment/convert.sh`

### Arguments

- `envFile ...` - File. Required. One or more files to convert.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


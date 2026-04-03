## `environmentFileBashCompatibleToDocker`

> Ensure an environment file is compatible with non-quoted docker environment

### Usage

    environmentFileBashCompatibleToDocker [ filename ]

Ensure an environment file is compatible with non-quoted docker environment files

### Arguments

- `filename` - File. Optional. Docker environment file to check for common issues

### Reads standard input

text - Environment file to convert. (Optional)

### Writes to standard output

text - Only if stdin is supplied and no `filename` arguments.

### Return codes

- `1` - if errors occur
- `0` - if file is valid


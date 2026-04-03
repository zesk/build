## `environmentFileDockerToBashCompatible`

> Ensure an environment file is compatible with non-quoted docker environment

### Usage

    environmentFileDockerToBashCompatible [ filename ... ]

Ensure an environment file is compatible with non-quoted docker environment files
May take a list of files to convert or stdin piped in
Outputs bash-compatible entries to stdout
Any output to stdout is considered valid output
Any output to stderr is errors in the file but is written to be compatible with a bash

### Arguments

- `filename ...` - File. Optional. Docker environment file to convert.

### Reads standard input

An environment file of any format

### Writes to standard output

Environment file in Bash-compatible format

### Return codes

- `1` - if errors occur
- `0` - if file is valid


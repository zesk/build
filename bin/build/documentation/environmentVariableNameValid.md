## `environmentVariableNameValid`

> Validates zero or more environment variable names.

### Usage

    environmentVariableNameValid variableName ... [ --help ]

Validates zero or more environment variable names.
- alpha
- digit
- underscore
First letter MUST NOT be a digit

### Arguments

- `variableName ...` - String. Required. Exit status 0 if all variables names are valid ones.
- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


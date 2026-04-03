## `bashFunctionDefined`

> Is a function defined in a bash source file?

### Usage

    bashFunctionDefined functionName file ... [ --help ]

Is a function defined in a bash source file?

### Arguments

- `functionName` - String. Required. Name of function to check.
- `file ...` - File. Required. One or more files to check if a function is defined within.
- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


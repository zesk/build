## `bashFunctionComment`

> Extract a bash comment from a file. Excludes lines containing

### Usage

    bashFunctionComment source functionName [ --help ]

Extract a bash comment from a file. Excludes lines containing the following tokens:

### Arguments

- `source` - File. Required. File where the function is defined.
- `functionName` - String. Required. The name of the bash function to extract the documentation for.
- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Requires

grep cut fileReverseLines __help
usageDocument


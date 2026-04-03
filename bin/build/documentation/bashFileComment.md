## `bashFileComment`

> Extract a bash comment from a file. Excludes lines containing

### Usage

    bashFileComment source lineNumber [ --help ]

Extract a bash comment from a file. Excludes lines containing the following tokens:

### Arguments

- `source` - File. Required. File where the function is defined.
- `lineNumber` - String. Required. Previously computed line number of the function.
- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Requires

head bashFinalComment
__help usageDocument


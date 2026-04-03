## `_arguments`

> Generic argument parsing using Bash comments.

### Usage

    _arguments this source [ --none ] [ arguments ... ]

Generic argument parsing using Bash comments.
Argument formatting (in comments) is as follows:
`...` token means one or more arguments may be passed.
`argumentType` is one of:
- File FileDirectory Directory LoadEnvironmentFile RealDirectory
- EmptyString String
- Boolean PositiveInteger Integer UnsignedInteger Number
- Executable Callable Function
- URL
Output is a temporary `stateFile` on line 1

### Arguments

- `this` - Function. Required. Function to collect arguments for. Assume handler function is "_$this".
- `source` - File. Required. File of the function to collect the specification.
- `--none` - Flag. Optional. If specified, state file is deleted prior to return regardless of handling.
- `arguments ...` - EmptyString. Optional. One or more arguments to parse.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


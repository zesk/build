## `isExecutable`

> Test if all arguments are executable binaries

### Usage

    isExecutable string

Test if all arguments are executable binaries
If no arguments are passed, returns exit code 1.

### Arguments

- `string` - String. Required. Path to binary to test if it is executable.

### Return codes

- `0` - All arguments are executable binaries
- `1` - One or or more arguments are not executable binaries


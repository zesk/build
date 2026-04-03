## `isFunction`

> Test if argument are bash functions

### Usage

    isFunction string

Test if argument are bash functions
If no arguments are passed, returns exit code 1.

### Arguments

- `string` - Required. String to test if it is a bash function. Builtins are supported. `.` is explicitly not supported to disambiguate it from the current directory `.`.

### Return codes

- `0` - argument is bash function
- `1` - argument is not a bash function

### Requires

catchArgument isUnsignedInteger bashDocumentation type


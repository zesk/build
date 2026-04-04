## `_deprecated`

> Logs all deprecated functions to application root in a file

### Usage

    _deprecated function

Logs all deprecated functions to application root in a file called `.deprecated`

### Arguments

- `function` - String. Required. Function which is deprecated. Use `${FUNCNAME[0]}` always if implemented in an old deprecated function.

### Examples

    _deprecated "${FUNCNAME[0]}"

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


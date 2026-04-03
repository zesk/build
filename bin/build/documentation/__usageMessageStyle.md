## `__usageMessageStyle`

> Style usage messages

### Usage

    __usageMessageStyle returnCode

Format arguments using the usage message return code to style output.
- `0` - meaning no error, style is `info`
- `1` - Environment error, style is `error`
- `2` - Argument error, style is `red`
- `*` - All additional errors, style is `orange`

### Arguments

- `returnCode` - UnsignedInteger. Required. Return code to use as the basis for styling output.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


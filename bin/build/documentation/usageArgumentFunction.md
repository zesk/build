## `usageArgumentFunction`

> Require an argument to be a function

### Usage

    usageArgumentFunction handler argument [ value ]

Require an argument to be a function

### Arguments

- `handler` - Function. Required. handler function to call upon failure.
- `argument` - String. Required. Name of the argument used in error messages.
- `value` - String. Optional. Value which should be a function otherwise an argument error is thrown.

### Return codes

- `2` - If `value` is not `isFunction`
- `0` - If `value` is `isFunction`


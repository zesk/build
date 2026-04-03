## `usageArgumentCallable`

> Require an argument to be a callable

### Usage

    usageArgumentCallable handler argument [ value ]

Require an argument to be a callable

### Arguments

- `handler` - Function. Required. handler function to call upon failure.
- `argument` - String. Required. Name of the argument used in error messages.
- `value` - String. Optional. Value which should be callable otherwise an argument error is thrown.

### Return codes

- `2` - If `value` is not `isCallable`
- `0` - If `value` is `isCallable`


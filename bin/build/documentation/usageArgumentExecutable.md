## `usageArgumentExecutable`

> Require an argument to be a executable

### Usage

    usageArgumentExecutable handler argument [ value ]

Require an argument to be a executable

### Arguments

- `handler` - Function. Required. handler function to call upon failure.
- `argument` - String. Required. Name of the argument used in error messages.
- `value` - String. Optional. Value which should be executable otherwise an argument error is thrown.

### Return codes

- `2` - If `value` is not `isExecutable`
- `0` - If `value` is `isExecutable`


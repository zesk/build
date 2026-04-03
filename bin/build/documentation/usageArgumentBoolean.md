## `usageArgumentBoolean`

> Require an argument to be a boolean value

### Usage

    usageArgumentBoolean handler argument [ value ]

Require an argument to be a boolean value

### Arguments

- `handler` - Function. Required. handler function to call upon failure.
- `argument` - String. Required. Name of the argument used in error messages.
- `value` - String. Optional. Value which should be non-blank otherwise an argument error is thrown.

### Return codes

- `2` - If `value` is not a boolean
- `0` - If `value` is a boolean


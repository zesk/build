## `usageArgumentURL`

> Require an argument to be a URL

### Usage

    usageArgumentURL handler argument [ value ]

Require an argument to be a URL

### Arguments

- `handler` - Function. Required. handler function to call upon failure.
- `argument` - String. Required. Name of the argument used in error messages.
- `value` - String. Optional. Value which should be a URL otherwise an argument error is thrown.

### Return codes

- `0` - If `value` is `urlValid`
- `2` - If `value` is not `urlValid`


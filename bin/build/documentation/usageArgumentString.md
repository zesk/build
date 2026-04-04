## `usageArgumentString`

> Require an argument to be non-blank

### Usage

    usageArgumentString handler argument [ value ]

Require an argument to be non-blank

### Arguments

- `handler` - Function. Required. Usage function to call upon failure.
- `argument` - String. Required. Name of the argument used in error messages.
- `value` - String. Optional. Value which should be non-blank otherwise an argument error is thrown.

### Return codes

- `2` - If `value` is blank
- `0` - If `value` is non-blank


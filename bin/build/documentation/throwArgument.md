## `throwArgument`

> Run `handler` with an argument error

### Usage

    throwArgument handler [ message ... ]

Run `handler` with an argument error

### Arguments

- `handler` - Function. Required. Failure command
- `message ...` - String. Optional. Error message to display.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Requires

isFunction returnArgument decorate debuggingStack


## `returnThrow`

> Run `handler` with a passed return code

### Usage

    returnThrow returnCode handler [ message ... ]

Run `handler` with a passed return code

### Arguments

- `returnCode` - Integer. Required. Return code.
- `handler` - Function. Required. Error handler.
- `message ...` - String. Optional. Error message

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


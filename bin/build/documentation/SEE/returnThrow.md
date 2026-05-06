## `returnThrow`

> Run `handler` with a passed return code

### Usage

    returnThrow returnCode handler [ message ... ]

Run `handler` with a passed return code

> Location: `bin/build/tools/_sugar.sh`

### Arguments

- `returnCode` - Integer. Required. Return code.
- `handler` - Function. Required. Error handler.
- `message ...` - String. Optional. Error message

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Requires

- {SEE:returnArgument}


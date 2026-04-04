## `catchReturn`

> Run binary and catch errors with handler

### Usage

    catchReturn handler binary ...

Run binary and catch errors with handler

### Arguments

- `handler` - Function. Required. Error handler.
- `binary ...` - Executable. Required. Any arguments are passed to `binary`.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Requires

returnArgument


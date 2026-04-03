## `catchCode`

> Run `command`, handle failure with `handler` with `code` and `command`

### Usage

    catchCode code handler command ...

Run `command`, handle failure with `handler` with `code` and `command` as error

### Arguments

- `code` - UnsignedInteger. Required. Exit code to return
- `handler` - Function. Required. Failure command, passed remaining arguments and error code.
- `command ...` - Callable. Required. Command to run.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Requires

isUnsignedInteger returnArgument isFunction isCallable


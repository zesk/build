## `catchArgument`

> Run `command`, upon failure run `handler` with an argument error

### Usage

    catchArgument handler command ... [ ... ]

Run `command`, upon failure run `handler` with an argument error

### Arguments

- `handler` - String. Required. Failure command
- `command ...` - Callable. Required. Command to run.
- `...` - Arguments. Optional. Arguments to `command`

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


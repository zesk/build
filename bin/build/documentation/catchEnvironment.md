## `catchEnvironment`

> Run `command`, upon failure run `handler` with an environment error

### Usage

    catchEnvironment handler command ...

Run `command`, upon failure run `handler` with an environment error

### Arguments

- `handler` - Function. Required. Failure command
- `command ...` - Callable. Required. Command to run.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


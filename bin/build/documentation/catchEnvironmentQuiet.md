## `catchEnvironmentQuiet`

> Run `handler` with an environment error

### Usage

    catchEnvironmentQuiet handler quietLog command ...

Run `handler` with an environment error

### Arguments

- `handler` - Function. Required. Failure command
- `quietLog` - File. Required. File to output log to temporarily for this command. If `quietLog` is `-` then creates a temporary file for the command which is deleted automatically.
- `command ...` - Callable. Required. Thing to run and append output to `quietLog`.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


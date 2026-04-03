## `executeInputSupport`

> Support arguments and stdin as arguments to an executor

### Usage

    executeInputSupport [ executor ... -- ] [ -- ] [ ... ]

Support arguments and stdin as arguments to an executor

### Arguments

- `executor ... --` - The command to run on each line of input or on each additional argument. Arguments to prefix the final variable argument can be supplied prior to an initial `--`.
- `--` - Alone after the executor forces `stdin` to be ignored. The `--` flag is also removed from the arguments passed to the executor.
- `...` - Any additional arguments are passed directly to the executor

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


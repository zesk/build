## `execute`

> Run binary and output failed command upon error

### Usage

    execute [ --help ] binary [ ... ]

Run binary and output failed command upon error

### Arguments

- `--help` - Flag. Optional. Display this help.
- `binary` - Callable. Required. Command to run.
- `...` - Arguments. Optional. Any arguments are passed to `binary`.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


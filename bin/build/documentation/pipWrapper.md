## `pipWrapper`

> Run pip whether it is installed as a module or

### Usage

    pipWrapper [ --bin binary ] [ --handler handler ] [ --help ] [ --debug ] [ ... ]

Run pip whether it is installed as a module or as a binary

### Arguments

- `--bin binary` - Executable. Optional. Binary for `pip`.
- `--handler handler` - Function. Optional. Use this error handler instead of the default error handler.
- `--help` - Flag. Optional. Display this help.
- `--debug` - Flag. Optional. Show outputs to `which` and `command -v` for `pip`
- `...` - Arguments. Optional. Arguments passed to `pip`

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


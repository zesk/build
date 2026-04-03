## `identicalWatch`

> Watch a project for changes and propagate them immediately upon

### Usage

    identicalWatch [ --help ] [ --handler handler ] ...

Watch a project for changes and propagate them immediately upon save. Can be quite dangerous so use with caution.
Still a known bug which trims the last end bracket from files

### Arguments

- `--help` - Flag. Optional. Display this help.
- `--handler handler` - Function. Optional. Use this error handler instead of the default error handler.
- `...` - Arguments. Required. Arguments to `identicalCheck` for your watch.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


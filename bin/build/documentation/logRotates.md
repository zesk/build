## `logRotates`

> Rotate log files

### Usage

    logRotates [ --dry-run ] logPath count

For all log files in logPath with extension `.log`, rotate them safely

### Arguments

- `--dry-run` - Flag. Optional. Do not change anything.
- `logPath` - Required. Path where log files exist.
- `count` - Required. Integer of log files to maintain.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


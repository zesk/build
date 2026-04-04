## `logDirectoryRotate`

> Rotate log files

### Usage

    logDirectoryRotate [ --help ] [ --dry-run ] [ --cull cullCount ] logPath count

For all log files in logPath with extension `.log`, rotate them safely.

### Arguments

- `--help` - Flag. Optional. Display this help.
- `--dry-run` - Flag. Optional. Do not change anything.
- `--cull cullCount` - UnsignedInteger. Optional. Delete log file indexes which exist beyond the `count`. Default is `0`.
- `logPath` - Directory. Required. Path where log files exist. Looks for files which match `*.log`.
- `count` - PositiveInteger. Required. Integer of log files to maintain.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


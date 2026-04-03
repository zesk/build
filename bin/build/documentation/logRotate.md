## `logRotate`

> Rotate a log file

### Usage

    logRotate [ --dry-run ] logFile count

Rotate a log file
Backs up files as:
    logFile
    logFile.1
    logFile.2
    logFile.3
But maintains file descriptors for `logFile`.

### Arguments

- `--dry-run` - Flag. Optional. Do not change anything.
- `logFile` - File. Required. A log file which exists.
- `count` - PositiveInteger. Required. Integer of log files to maintain.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


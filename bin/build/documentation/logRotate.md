## `logRotate`

> Rotate a log file

### Usage

    logRotate [ --help ] [ --dry-run ] [ --cull cullCount ] logFile count

Rotates a log file by adding a digit to the end numerically, and moves logs such that the most recent
log backup suffix is `.1` and the oldest log backup suffix is `.count`.
Backs up files as:
    logFile
    logFile.1
    logFile.2
    logFile.3
`--cull` will delete `cullCount` files in addition to the backup files if they exist. This is useful if you change this number
from a higher to a lower number and want the extra files deleted.
But maintains file descriptors for `logFile`.

### Arguments

- `--help` - Flag. Optional. Display this help.
- `--dry-run` - Flag. Optional. Do not change anything.
- `--cull cullCount` - UnsignedInteger. Optional. Delete log file indexes which exist beyond the `count`. Default is `0`.
- `logFile` - File. Required. A log file which exists.
- `count` - PositiveInteger. Required. Integer of log file backups to maintain.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


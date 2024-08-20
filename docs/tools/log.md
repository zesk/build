# Log Functions

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

## Rotation

### `rotateLog` - Rotate a log file

Rotate a log file

Backs up files as:

    logFile
    logFile.1
    logFile.2
    logFile.3

But maintains file` descriptors for `logFile`.

- Location: `bin/build/tools/log.sh`

#### Arguments

- `logFile` - Required. A log file which exists.
- `count` - Required. Integer of log files to maintain.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `rotateLogs` - Rotate log files

Rotate log files
For all log files in logPath with extension `.log`, rotate them safely

- Location: `bin/build/tools/log.sh`

#### Arguments

- `logPath` - Required. Path where log files exist.
- `count` - Required. Integer of log files to maintain.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

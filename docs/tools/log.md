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

#### Usage

    rotateLog [ --dry-run ] logFile count
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

### `rotateLogs` - Rotate log files

Rotate log files
For all log files in logPath with extension `.log`, rotate them safely

#### Usage

    rotateLogs [ --dry-run ] logPath count
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

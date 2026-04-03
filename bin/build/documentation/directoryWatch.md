## `directoryWatch`

> Watch a directory

### Usage

    directoryWatch [ --help ] [ --handler handler ] [ --verbose ] [ --file modifiedFile ] [ --modified modifiedTimestamp ] [ --timeout secondsToRun ] [ --state stateFile ] directory [ findArguments ... ]

Watch a directory

### Arguments

- `--help` - Flag. Optional. Display this help.
- `--handler handler` - Function. Optional. Use this error handler instead of the default error handler.
- `--verbose` - Flag. Optional. Be verbose.
- `--file modifiedFile` - File. Optional. Last known modified file in this directory.
- `--modified modifiedTimestamp` - UnsignedInteger. Optional. Last known modification timestamp in this directory.
- `--timeout secondsToRun` - UnsignedInteger. Optional. Last known modification timestamp in this directory.
- `--state stateFile` - File. Optional. Output of `fileModificationTimes` will be saved here (and modified)
- `directory` - Directory. Required. Directory to watch
- `findArguments ...` - Arguments. Optional. Passed to find to filter the files examined.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


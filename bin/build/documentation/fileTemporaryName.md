## `fileTemporaryName`

> Wrapper for `mktemp`. Generate a temporary file name, and fail

### Usage

    fileTemporaryName handler [ --help ] [ ... ]

Wrapper for `mktemp`. Generate a temporary file name, and fail using a function

### Arguments

- `handler` - Function. Required. Function to call on failure. Function Type: returnMessage
- `--help` - Flag. Optional. Display this help.
- `...` - Arguments. Optional. Any additional arguments are passed through.

### Debugging settings

Append to the value of `BUILD_DEBUG` (a comma-delimited (`,`) list) and add these tokens to enable debugging:

- `temp` - Logs backtrace of all temporary files to a file in application root named after this function to detect and clean up leaks

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Environment

- {SEE:BUILD_DEBUG.sh}


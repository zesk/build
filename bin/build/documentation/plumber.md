## `plumber`

> Run command and detect any global or local leaks

### Usage

    plumber [ command ... ] [ --temporary tempPath ] [ --leak envName ... ] [ --verbose ] [ --help ]

Run command and detect any global or local leaks

### Arguments

- `command ...` - Callable. Command to run
- `--temporary tempPath` - Directory. Optional. Use this for the temporary path.
- `--leak envName ...` - EnvironmentVariable. Variable name which is OK to leak.
- `--verbose` - Flag. Optional. Be verbose.
- `--help` - Flag. Optional. Display this help.

### Debugging settings

Append to the value of `BUILD_DEBUG` (a comma-delimited (`,`) list) and add these tokens to enable debugging:

- `plumber-verbose` - The plumber outputs the exact variable captures before and after

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


## `dumpEnvironmentUnsafe`

> Output the environment shamelessly (not secure, not recommended)

### Usage

    dumpEnvironmentUnsafe [ --maximum-length maximumLength ] [ --skip-env environmentVariable ] [ --show-skipped ] [ --help ]

Output the environment shamelessly (not secure, not recommended)

### Arguments

- `--maximum-length maximumLength` - PositiveInteger. Optional. The maximum number of characters to output for each environment variable.
- `--skip-env environmentVariable` - EnvironmentVariable. Optional. Skip this environment variable (must match exactly).
- `--show-skipped` - Flag. Show skipped environment variables.
- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


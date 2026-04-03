## `dumpEnvironment`

> Output the environment but try to hide secure value

### Usage

    dumpEnvironment [ --maximum-length maximumLength ] [ --skip-env environmentVariable ] [ --show-skipped ] [ --secure-match matchString ] [ --secure-suffix secureSuffix  ] [ --help ]

Output the environment but try to hide secure value

### Arguments

- `--maximum-length maximumLength` - PositiveInteger. Optional. The maximum number of characters to output for each environment variable.
- `--skip-env environmentVariable` - EnvironmentVariable. Optional. Skip this environment variable (must match exactly).
- `--show-skipped` - Flag. Show skipped environment variables.
- `--secure-match matchString` - String. Optional. If an environment variable matches any case-insensitive part of this string, then hide it. If nothing specified, uses a `secret` `key` and `password`. If one value is specified the list is reset to zero. To show all variables pass a blank or `-` value here.
- `--secure-suffix secureSuffix ` - EmptyString. Optional. Suffix to display after hidden arguments.
- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


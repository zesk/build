## `mapEnvironment`

> Convert tokens in files to environment variable values

### Arguments

- `environmentVariableName` - String. Optional. Map this value only. If not specified, all environment variables are mapped.
- `--prefix` - String. Optional. Prefix character for tokens, defaults to `{`.
- `--suffix` - String. Optional. Suffix character for tokens, defaults to `}`.
- `--search-filter` - Zero or more. Callable. Filter for search tokens. (e.g. `lowercase`)
- `--replace-filter` - Zero or more. Callable. Filter for replacement strings. (e.g. `textTrim`)
- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


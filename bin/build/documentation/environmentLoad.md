## `environmentLoad`

> Safely load an environment from stdin (no code execution)

### Usage

    environmentLoad [ --verbose ] [ --debug ] [ --prefix ] [ --context ] [ --ignore environmentName ] [ --secure environmentName ] [ --secure-defaults ] [ --execute arguments ... ] [ --help ]

Safely load an environment from stdin (no code execution)

### Arguments

- `--verbose` - Flag. Optional. Output errors with variables.
- `--debug` - Flag. Optional. Debugging mode, for developers probably.
- `--prefix` - String. Optional. Prefix each environment variable defined with this string. e.g. `NAME` -> `DSN_NAME` for `--prefix DSN_`
- `--context` - String. Optional. Name of the context for debugging or error messages. (e.g. what is this doing for whom and why)
- `--ignore environmentName` - String. Optional. Environment value to ignore on load.
- `--secure environmentName` - String. Optional. If found, entire load fails.
- `--secure-defaults` - Flag. Optional. Add a list of environment variables considered security risks to the `--ignore` list.
- `--execute arguments ...` - Callable. Optional. All additional arguments are passed to callable after loading environment.
- `--help` - Flag. Optional. Display this help.

### Return codes

- `2` - if file does not exist; outputs an error
- `0` - if files are loaded successfully


## `mapEnvironment`

> Convert tokens in files to environment variable values

### Arguments

- `environmentVariableName` - String. Optional. Map this value only. If not specified, all environment variables are mapped.
- `--prefix` - String. Optional. Prefix character for tokens, defaults to `{`.
- `--suffix` - String. Optional. Suffix character for tokens, defaults to `}`.
- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Requires

- {SEE:environmentVariables}
- cat
- {SEE:throwEnvironment}
- {SEE:catchEnvironment}
- {SEE:throwArgument}
- {SEE:decorate}
- {SEE:validate}

### See Also

- ## `mapValue`


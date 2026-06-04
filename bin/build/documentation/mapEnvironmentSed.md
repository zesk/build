### `mapEnvironmentSed`

> Convert tokens in files to environment variable values

#### Arguments

- `environmentName` - String. Optional. Map this value only. If not specified, all environment variables are mapped.
- `--prefix` - String. Optional. Prefix character for tokens, defaults to `{`.
- `--suffix` - String. Optional. Suffix character for tokens, defaults to `}`.
- `--help` - Flag. Optional. Display this help.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Requires

- {SEE:throwArgument}
- [`read`]({rel}/guide/builtin.md#read)
- {SEE:environmentVariables}
- {SEE:decorate}
- sed
- cat
- rm
- {SEE:throwEnvironment}
- {SEE:catchEnvironment}
- {SEE:returnClean}
- {SEE:validate}
- {SEE:fileTemporaryName}

#### See Also

- {SEE:mapValue}


### `mapEnvironmentFun`

> Convert tokens in files to environment variable values

#### Arguments

- `environmentName` - String. Optional. Map this value only. If not specified, all environment variables are mapped.
- `--env-file envFile` - File. Optional. Load this environment file prior to processing input.
- `--prefix` - String. Optional. Prefix character for tokens, defaults to `{`.
- `--suffix` - String. Optional. Suffix character for tokens, defaults to `}`.
- `--help` - Flag. Optional. Display this help.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Requires

- {SEE:throwArgument}
- [decorate]({rel}tools/decorate.md#decorate) - decorate text using colors and styles ([source](https://github.com/zesk/build/blob/main/bin/build/tools/decorate/core.sh#L144))
- {SEE:validate}

#### See Also

- [mapEnvironment]({rel}tools/map.md#mapenvironment) - Convert tokens in files to environment variable values ([source](https://github.com/zesk/build/blob/main/bin/build/tools/map.sh#L259))
- {SEE:mapValue}


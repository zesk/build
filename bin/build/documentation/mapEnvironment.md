### `mapEnvironment`

> Convert tokens in files to environment variable values

#### Arguments

- `environmentVariableName` - String. Optional. Map this value only. If not specified, all environment variables are mapped.
- `--prefix` - String. Optional. Prefix character for tokens, defaults to `{`.
- `--suffix` - String. Optional. Suffix character for tokens, defaults to `}`.
- `--help` - Flag. Optional. Display this help.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Requires

- [environmentVariables]({rel}tools/environment.md#environmentvariables) - Output a list of environment variables and ignore function definitions ([source](https://github.com/zesk/build/blob/main/bin/build/tools/environment.sh#L130))
- [`cat`]({rel}guide/command.md#cat)
- {SEE:throwEnvironment}
- [catchEnvironment]({rel}tools/sugar-core.md#catchenvironment) - Run \`command\`, upon failure run \`handler\` with an environment error ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L247))
- {SEE:throwArgument}
- [decorate]({rel}tools/decorate.md#decorate) - decorate text using colors and styles ([source](https://github.com/zesk/build/blob/main/bin/build/tools/decorate/core.sh#L144))
- {SEE:validate}

#### See Also

- {SEE:mapValue}


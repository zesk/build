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
- [`read`]({rel}guide/builtin.md#read)
- [environmentVariables]({rel}tools/environment.md#environmentvariables) - Output a list of environment variables and ignore function definitions ([source](https://github.com/zesk/build/blob/main/bin/build/tools/environment.sh#L130))
- [decorate]({rel}tools/decorate.md#decorate) - decorate text using colors and styles ([source](https://github.com/zesk/build/blob/main/bin/build/tools/decorate/core.sh#L144))
- [`sed`]({rel}guide/command.md#sed)
- [`cat`]({rel}guide/command.md#cat)
- [`rm`]({rel}guide/command.md#rm)
- {SEE:throwEnvironment}
- [catchEnvironment]({rel}tools/sugar-core.md#catchenvironment) - Run \`command\`, upon failure run \`handler\` with an environment error ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L247))
- {SEE:returnClean}
- {SEE:validate}
- [fileTemporaryName]({rel}tools/file.md#filetemporaryname) - Wrapper for \`mktemp\`. Generate a temporary file name, and fail ([source](https://github.com/zesk/build/blob/main/bin/build/tools/file.sh#L944))

#### See Also

- {SEE:mapValue}


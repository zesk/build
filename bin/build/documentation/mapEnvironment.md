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
- [throwEnvironment]({rel}tools/sugar-core.md#throwenvironment) - Run \`handler\` with an environment error ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L226))
- [catchEnvironment]({rel}tools/sugar-core.md#catchenvironment) - Run \`command\`, upon failure run \`handler\` with an environment error ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L247))
- [throwArgument]({rel}tools/sugar-core.md#throwargument) - Run \`handler\` with an argument error ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L215))
- [decorate]({rel}tools/decorate.md#decorate) - Singular decoration function ([source](https://github.com/zesk/build/blob/main/bin/build/tools/decorate/core.sh#L89))
- [validate]({rel}tools/validate.md#validate) - Validate a value by type ([source](https://github.com/zesk/build/blob/main/bin/build/tools/validate.sh#L95))

#### See Also

- [mapValue]({rel}tools/map.md#mapvalue) - Maps a string using an environment file ([source](https://github.com/zesk/build/blob/main/bin/build/tools/map.sh#L155))


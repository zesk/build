### `mapFunction`

> Convert tokens in input to values

#### Return codes

- `120` - Map function exited early
- `130` - User interrupt (exits early)
- `141` - System interrupt (exits early)

#### Requires

- [`cat`]({rel}guide/command.md#cat)
- {SEE:throwEnvironment}
- [catchEnvironment]({rel}tools/sugar-core.md#catchenvironment) - Run \`command\`, upon failure run \`handler\` with an environment error ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L247))
- {SEE:throwArgument}
- [decorate]({rel}tools/decorate.md#decorate) - decorate text using colors and styles ([source](https://github.com/zesk/build/blob/main/bin/build/tools/decorate/core.sh#L144))
- {SEE:validate}

#### See Also

- {SEE:mapValue}
- [mapEnvironment]({rel}tools/map.md#mapenvironment) - Convert tokens in files to environment variable values ([source](https://github.com/zesk/build/blob/main/bin/build/tools/map.sh#L259))


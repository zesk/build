### `mapFunction`

> Convert tokens in input to values

#### Return codes

- `120` - Map function exited early
- `130` - User interrupt (exits early)
- `141` - System interrupt (exits early)

#### Requires

- [`cat`]({rel}guide/command.md#cat)
- [throwEnvironment]({rel}tools/sugar-core.md#throwenvironment) - Run \`handler\` with an environment error ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L226))
- [catchEnvironment]({rel}tools/sugar-core.md#catchenvironment) - Run \`command\`, upon failure run \`handler\` with an environment error ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L247))
- [throwArgument]({rel}tools/sugar-core.md#throwargument) - Run \`handler\` with an argument error ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L215))
- [decorate]({rel}tools/decorate.md#decorate) - Singular decoration function ([source](https://github.com/zesk/build/blob/main/bin/build/tools/decorate/core.sh#L89))
- [validate]({rel}tools/validate.md#validate) - Validate a value by type ([source](https://github.com/zesk/build/blob/main/bin/build/tools/validate.sh#L95))

#### See Also

- [mapValue]({rel}tools/map.md#mapvalue) - Maps a string using an environment file ([source](https://github.com/zesk/build/blob/main/bin/build/tools/map.sh#L155))
- [mapEnvironment]({rel}tools/map.md#mapenvironment) - Convert tokens in files to environment variable values ([source](https://github.com/zesk/build/blob/main/bin/build/tools/map.sh#L259))


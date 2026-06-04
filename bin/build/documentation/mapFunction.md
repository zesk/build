### `mapFunction`

> Convert tokens in input to values

#### Return codes

- `120` - Map function exited early
- `130` - User interrupt (exits early)
- `141` - System interrupt (exits early)

#### Requires

- cat
- {SEE:throwEnvironment}
- {SEE:catchEnvironment}
- {SEE:throwArgument}
- {SEE:decorate}
- {SEE:validate}

#### See Also

- {SEE:mapValue}
- [mapEnvironment]({rel}tools/map.md#mapenvironment) - Convert tokens in files to environment variable values ([source](https://github.com/zesk/build/blob/main/bin/build/tools/map.sh#L259))


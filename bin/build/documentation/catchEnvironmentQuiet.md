### `catchEnvironmentQuiet`

> Run `handler` with an environment error

#### Usage

    catchEnvironmentQuiet handler quietLog command ...

Run `handler` with an environment error

> Location: `bin/build/tools/sugar.sh`

#### Arguments

- `handler` - Function. Required. Failure command
- `quietLog` - File. Required. File to output log to temporarily for this command. If `quietLog` is `-` then creates a temporary file for the command which is deleted automatically.
- `command ...` - Callable. Required. Thing to run and append output to `quietLog`.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Requires

- [isFunction]({rel}tools/type.md#isfunction) - Test if argument are bash functions ([source](https://github.com/zesk/build/blob/main/bin/build/tools/type.sh#L177))
- [returnArgument]({rel}tools/sugar-core.md#returnargument) - Return \`argument\` error code. Outputs \`message ...\` to \`stderr\`. ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L257))
- [debuggingStack]({rel}tools/dump.md#debuggingstack) - Dump the function and include stacks and the current environment ([source](https://github.com/zesk/build/blob/main/bin/build/tools/dump.sh#L18))
- [throwEnvironment]({rel}tools/sugar-core.md#throwenvironment) - Run \`handler\` with an environment error ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L226))


### `catchCode`

> Run `command`, handle failure with `handler` with `code` and `command`

#### Usage

    catchCode code handler command ... [ ... ]

Run `command`, handle failure with `handler` with `code` and `command` as error

> Location: `bin/build/tools/_sugar.sh`

#### Arguments

- `code` - UnsignedInteger. Required. Exit code to return
- `handler` - Function. Required. Failure command, passed remaining arguments and error code.
- `command ...` - Callable. Required. Command to run.
- `...` - Arguments. Optional. Arguments to `command`

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Requires

- [isUnsignedInteger]({rel}tools/type.md#isunsignedinteger) - Is value an unsigned integer? ([source](https://github.com/zesk/build/blob/main/bin/build/tools/example.sh#L163))
- [returnArgument]({rel}tools/sugar-core.md#returnargument) - Return \`argument\` error code. Outputs \`message ...\` to \`stderr\`. ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L257))
- [isFunction]({rel}tools/type.md#isfunction) - Test if argument are bash functions ([source](https://github.com/zesk/build/blob/main/bin/build/tools/type.sh#L177))
- [isCallable]({rel}tools/type.md#iscallable) - Test if all arguments are callable as a command ([source](https://github.com/zesk/build/blob/main/bin/build/tools/type.sh#L199))


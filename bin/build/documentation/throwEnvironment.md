### `throwEnvironment`

> Run `handler` with an environment error

#### Usage

    throwEnvironment handler [ message ... ]

Run `handler` with an environment error

> Location: `bin/build/tools/_sugar.sh`

#### Arguments

- `handler` - Function. Required. Error handler.
- `message ...` - String. Optional. Error message

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Requires

- [isFunction]({rel}tools/type.md#isfunction) - Test if argument are bash functions ([source](https://github.com/zesk/build/blob/main/bin/build/tools/type.sh#L177))
- [returnArgument]({rel}tools/sugar-core.md#returnargument) - Return \`argument\` error code. Outputs \`message ...\` to \`stderr\`. ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L257))
- [decorate]({rel}tools/decorate.md#decorate) - Singular decoration function ([source](https://github.com/zesk/build/blob/main/bin/build/tools/decorate/core.sh#L89))
- [debuggingStack]({rel}tools/dump.md#debuggingstack) - Dump the function and include stacks and the current environment ([source](https://github.com/zesk/build/blob/main/bin/build/tools/dump.sh#L18))


### `booleanChoose`

> Boolean selector

#### Usage

    booleanChoose testValue [ trueChoice ] [ falseChoice ]

Boolean selector

> Location: `bin/build/tools/_sugar.sh`

#### Arguments

- `testValue` - Boolean. Required. Test value
- `trueChoice` - EmptyString. Optional. Value to output when testValue is `true`
- `falseChoice` - EmptyString. Optional. Value to output when testValue is `false`

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Requires

- [isBoolean]({rel}tools/sugar-core.md#isboolean) - Boolean test ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L79))[returnArgument]({rel}tools/sugar-core.md#returnargument) - Return \`argument\` error code. Outputs \`message ...\` to \`stderr\`. ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L257))[`printf`]({rel}/guide/builtin.md#printf)


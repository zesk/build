### `isFunction`

> Test if argument are bash functions

#### Usage

    isFunction string [ --help ]

Test if argument are bash functions
If no arguments are passed, returns exit code 1.

> Location: `bin/build/tools/type.sh`

#### Arguments

- `string` - String. Required. String to test if it is a bash function. Builtins are supported. `.` is explicitly not supported to disambiguate it from the current directory `.`.
- `--help` - Flag. Optional. Display this help.

#### Return codes

- `0` - argument is bash function
- `1` - argument is not a bash function

#### Requires

- [catchArgument]({rel}tools/sugar-core.md#catchargument) - Run \`command\`, upon failure run \`handler\` with an argument error ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L238))
- {SEE:isUnsignedInteger}
- [bashDocumentation]({rel}tools/documentation.md#bashdocumentation) - Universal function documentation ([source](https://github.com/zesk/build/blob/main/bin/build/tools/usage.sh#L59))
- [`type`]({rel}guide/builtin.md#type)
- [helpArgument]({rel}tools/argument.md#helpargument) - Simple help argument handler. ([source](https://github.com/zesk/build/blob/main/bin/build/tools/argument.sh#L576))


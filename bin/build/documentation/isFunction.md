### `isFunction`

> Is argument a bash function?

#### Usage

    isFunction string [ --help ]

Test if arguments are bash functions.
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
- [isUnsignedInteger]({rel}tools/type.md#isunsignedinteger) - Is value an unsigned integer? ([source](https://github.com/zesk/build/blob/main/bin/build/tools/example.sh#L163))
- [bashDocumentation]({rel}tools/documentation.md#bashdocumentation) - Universal function documentation ([source](https://github.com/zesk/build/blob/main/bin/build/tools/usage.sh#L59))
- [`type`]({rel}guide/builtin.md#type)
- [helpArgument]({rel}tools/argument.md#helpargument) - Simple help argument handler. ([source](https://github.com/zesk/build/blob/main/bin/build/tools/argument.sh#L576))


### `isCallable`

> Test if all arguments are callable as a command

#### Usage

    isCallable string

Test if all arguments are callable as a command
If no arguments are passed, returns exit code 1.

> Location: `bin/build/tools/type.sh`

#### Arguments

- `string` - EmptyString. Required. Path to binary to test if it is executable.

#### Return codes

- `0` - All arguments are callable as a command
- `1` - One or or more arguments are callable as a command

#### Requires

- [throwArgument]({rel}tools/sugar-core.md#throwargument) - Run \`handler\` with an argument error ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L215))
- [helpArgument]({rel}tools/argument.md#helpargument) - Simple help argument handler. ([source](https://github.com/zesk/build/blob/main/bin/build/tools/argument.sh#L576))
- [isExecutable]({rel}tools/type.md#isexecutable) - Test if all arguments are executable binaries ([source](https://github.com/zesk/build/blob/main/bin/build/tools/type.sh#L219))
- [isFunction]({rel}tools/type.md#isfunction) - Test if argument are bash functions ([source](https://github.com/zesk/build/blob/main/bin/build/tools/type.sh#L177))


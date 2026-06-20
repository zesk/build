### `isExecutable`

> Test if all arguments are executable binaries

#### Usage

    isExecutable string

Test if all arguments are executable binaries
If no arguments are passed, returns exit code 1.

> Location: `bin/build/tools/type.sh`

#### Arguments

- `string` - String. Required. Path to binary to test if it is executable.

#### Return codes

- `0` - All arguments are executable binaries
- `1` - One or or more arguments are not executable binaries

#### Environment

- [`PATH` Executable Search Path]({rel}env/#bash) – **DirectoryList**. A colon `:` separated list of paths to search for

#### Requires

- [throwArgument]({rel}tools/sugar-core.md#throwargument) - Run \`handler\` with an argument error ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L215))
- [helpArgument]({rel}tools/argument.md#helpargument) - Simple help argument handler. ([source](https://github.com/zesk/build/blob/main/bin/build/tools/argument.sh#L576))
- [`type`]({rel}guide/builtin.md#type)


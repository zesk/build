### `bashFunctionComment`

> Output the comment for a function in a file

#### Usage

    bashFunctionComment source functionName [ --help ]

Outputs a function comment in a file.
Excludes lines similarly to `bashFirstComment`.

> Location: `bin/build/tools/bash.sh`

#### Arguments

- `source` - File. Required. File where the function is defined.
- `functionName` - String. Required. The name of the bash function to extract the documentation for.
- `--help` - Flag. Optional. Display this help.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Requires

- [`grep`]({rel}guide/command.md#grep)
- [`cut`]({rel}guide/command.md#cut)
- [fileReverseLines]({rel}tools/file.md#filereverselines) - Reverse output lines ([source](https://github.com/zesk/build/blob/main/bin/build/tools/platform.sh#L106))
- [helpArgument]({rel}tools/argument.md#helpargument) - Simple help argument handler. ([source](https://github.com/zesk/build/blob/main/bin/build/tools/argument.sh#L576))
- [bashDocumentation]({rel}tools/documentation.md#bashdocumentation) - Universal function documentation ([source](https://github.com/zesk/build/blob/main/bin/build/tools/usage.sh#L59))

#### See Also

- [bashFirstComment]({rel}tools/bash.md#bashfirstcomment) - Extract first comment from a stream ([source](https://github.com/zesk/build/blob/main/bin/build/tools/bash.sh#L588))


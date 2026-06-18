### `bashFileComment`

> Extract a bash comment from a file. Excludes lines containing

#### Usage

    bashFileComment source lineNumber [ --help ]

Extract a bash comment from a file. Excludes lines containing the following tokens:

> Location: `bin/build/tools/bash.sh`

#### Arguments

- `source` - File. Required. File where the function is defined.
- `lineNumber` - String. Required. Previously computed line number of the function.
- `--help` - Flag. Optional. Display this help.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Requires

- [`head`]({rel}guide/command.md#head)
- [bashFinalComment]({rel}tools/bash.md#bashfinalcomment) - Extract final comment from a stream ([source](https://github.com/zesk/build/blob/main/bin/build/tools/bash.sh#L561))
- [helpArgument]({rel}tools/argument.md#helpargument) - Simple help argument handler. ([source](https://github.com/zesk/build/blob/main/bin/build/tools/argument.sh#L576))
- [bashDocumentation]({rel}tools/documentation.md#bashdocumentation) - Universal function documentation ([source](https://github.com/zesk/build/blob/main/bin/build/tools/usage.sh#L59))


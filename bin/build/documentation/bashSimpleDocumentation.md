### `bashSimpleDocumentation`

> Simpler `bashDocumentation`

#### Usage

    bashSimpleDocumentation [ --help ] source function returnCode [ message ... ]

Output a simple error message for a function.

> Location: `bin/build/tools/usage.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.
- `source` - File. Required. File where documentation exists.
- `function` - String. Required. Function to document.
- `returnCode` - UnsignedInteger. Required. Exit code to return.
- `message ...` - String. Optional. Message to display to the user.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Requires

- [bashFunctionComment]({rel}tools/bash.md#bashfunctioncomment) - Output the comment for a function in a file ([source](https://github.com/zesk/build/blob/main/bin/build/tools/bash.sh#L631))
- [decorate]({rel}tools/decorate.md#decorate) - Singular decoration function ([source](https://github.com/zesk/build/blob/main/bin/build/tools/decorate/core.sh#L89))
- [`read`]({rel}guide/builtin.md#read)
- [`printf`]({rel}guide/builtin.md#printf)
- [returnCodeString]({rel}tools/sugar-core.md#returncodestring) - Output the exit code as a string ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L60))
- [helpArgument]({rel}tools/argument.md#helpargument) - Simple help argument handler. ([source](https://github.com/zesk/build/blob/main/bin/build/tools/argument.sh#L576))
- [bashDocumentation]({rel}tools/documentation.md#bashdocumentation) - Universal function documentation ([source](https://github.com/zesk/build/blob/main/bin/build/tools/usage.sh#L59))


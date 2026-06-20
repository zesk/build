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
- {SEE:decorate}
- [`read`]({rel}guide/builtin.md#read)
- [`printf`]({rel}guide/builtin.md#printf)
- {SEE:returnCodeString}
- {SEE:helpArgument}
- [bashDocumentation]({rel}tools/documentation.md#bashdocumentation) - Universal function documentation ([source](https://github.com/zesk/build/blob/main/bin/build/tools/usage.sh#L59))


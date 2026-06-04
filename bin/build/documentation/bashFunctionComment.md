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

- grep
- cut
- {SEE:fileReverseLines}
- {SEE:helpArgument}
- {SEE:bashDocumentation}

#### See Also

- [bashFirstComment]({rel}tools/bash.md#bashfirstcomment) - Extract first comment from a stream ([source](https://github.com/zesk/build/blob/main/bin/build/tools/bash.sh#L588))


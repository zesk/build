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


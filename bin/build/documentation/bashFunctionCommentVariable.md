## `bashFunctionCommentVariable`

> Gets a list of the variable values from a bash

### Usage

    bashFunctionCommentVariable source functionName variableName [ --prefix ] [ --i | --insensitive ] [ --help ]

Gets a list of the variable values from a bash function comment

### Arguments

- `source` - File. Required. File where the function is defined.
- `functionName` - String. Required. The name of the bash function to extract the documentation for.
- `variableName` - string. Required. Get this variable value
- `--prefix` - flag. Optional. Find variables with the prefix `variableName`
--i |- ` --insensitive` - Flag. Optional. Case-insensitive match.
- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


## `returnClean`

> Delete files or directories and return the same exit code

### Usage

    returnClean exitCode [ item ]

Delete files or directories and return the same exit code passed in.

### Arguments

- `exitCode` - Integer. Required. Exit code to return.
- `item` - Exists. Optional. One or more files or folders to delete, failures are logged to stderr.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Requires

isUnsignedInteger returnArgument throwEnvironment bashDocumentation throwArgument __help


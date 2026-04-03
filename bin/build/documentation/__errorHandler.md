## `errorHandler`

> The main error handler signature used in Zesk Build.

### Usage

    errorHandler exitCode [ message ... ]

The main error handler signature used in Zesk Build.
Example: Here, `handler` is a string variable which references our `errorHandler` function – when used in your code:
Example

### Arguments

- `exitCode` - Integer. Required. The exit code to handle.
- `message ...` - EmptyString. Optional. The message to display to the user about what caused the error.

### Examples

    tempFile=$(fileTemporaryName "$handler") || return $?
    catchEnvironment "$handler" rm -f "$tempFile" || return $?
    muzzle validate "$handler" Executable "${FUNCNAME[0]} requirements" curl sftp || return $?

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


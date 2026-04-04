## `returnUndo`

> Run a function and preserve exit code

### Usage

    returnUndo [ --help ] code [ undoFunction ] [ -- ]

Run a function and preserve exit code
Returns `code`
As a caveat, your command to `undo` can NOT take the argument `--` as a parameter.

### Arguments

- `--help` - Flag. Optional. Display this help.
- `code` - UnsignedInteger. Required. Exit code to return.
- `undoFunction` - Callable. Optional. Command to run to undo something. Return status is ignored.
- `--` - Flag. Optional. Used to delimit multiple commands.

### Examples

    local undo thing
    thing=$(catchEnvironment "$handler" createLargeResource) || return $?
    undo+=(-- deleteLargeResource "$thing")
    thing=$(catchEnvironment "$handler" createMassiveResource) || returnUndo $? "${undo[@]}" || return $?
    undo+=(-- deleteMassiveResource "$thing")

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error


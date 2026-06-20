### `returnUndo`

> Run a function and preserve exit code

#### Usage

    returnUndo [ --help ] code [ undoFunction ] [ -- ]

Run a function and preserve exit code
Returns `code`
As a caveat, your command to `undo` can NOT take the argument `--` as a parameter.

> Location: `bin/build/tools/sugar.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.
- `code` - UnsignedInteger. Required. Exit code to return.
- `undoFunction` - Callable. Optional. Command to run to undo something. Return status is ignored.
- `--` - Flag. Optional. Used to delimit multiple commands.

#### Examples

    local undo thing
    thing=$(catchEnvironment "$handler" createLargeResource) || return $?
    undo+=(-- deleteLargeResource "$thing")
    thing=$(catchEnvironment "$handler" createMassiveResource) || returnUndo $? "${undo[@]}" || return $?
    undo+=(-- deleteMassiveResource "$thing")

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Requires

- [isUnsignedInteger]({rel}tools/type.md#isunsignedinteger) - Is value an unsigned integer? ([source](https://github.com/zesk/build/blob/main/bin/build/tools/example.sh#L163))
- {SEE:throwArgument}
- [decorate]({rel}tools/decorate.md#decorate) - decorate text using colors and styles ([source](https://github.com/zesk/build/blob/main/bin/build/tools/decorate/core.sh#L144))
- [execute]({rel}tools/sugar-core.md#execute) - Run binary and output failed command upon error ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L140))
- [bashDocumentation]({rel}tools/documentation.md#bashdocumentation) - Universal function documentation ([source](https://github.com/zesk/build/blob/main/bin/build/tools/usage.sh#L59))


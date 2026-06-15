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

#### Reads standard input

{stdin}

#### Writes to standard output

{stdout}

#### Writes to standard error

{stderr}

#### Debugging settings

Append to the value of `BUILD_DEBUG` (a comma-delimited (`,`) list) and add these tokens to enable debugging:

{build_debug}

#### Examples

    local undo thing
    thing=$(catchEnvironment "$handler" createLargeResource) || return $?
    undo+=(-- deleteLargeResource "$thing")
    thing=$(catchEnvironment "$handler" createMassiveResource) || returnUndo $? "${undo[@]}" || return $?
    undo+=(-- deleteMassiveResource "$thing")


#### Sample Output

{output}

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Local cache

{local_cache}

#### Environment

{environment}

#### Requires



#### See Also

{see}

#### Credits

Thanks to [{credits}]({source}).

#### Review Status

File `bin/build/tools/sugar.sh`, function `returnUndo` was reviewed {reviewed}.

#### Errors

{error}

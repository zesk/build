### `catchCode`

> Run `command`, handle failure with `handler` with `code` and `command`

#### Usage

    catchCode code handler command ... [ ... ]

Run `command`, handle failure with `handler` with `code` and `command` as error



> Location: `bin/build/tools/_sugar.sh`

#### Arguments

- `code` - UnsignedInteger. Required. Exit code to return
- `handler` - Function. Required. Failure command, passed remaining arguments and error code.
- `command ...` - Callable. Required. Command to run.
- `...` - Arguments. Optional. Arguments to `command`

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

{example}

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

File `bin/build/tools/_sugar.sh`, function `catchCode` was reviewed {reviewed}.

#### Errors

{error}

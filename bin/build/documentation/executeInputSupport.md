### `executeInputSupport`

> Support arguments and stdin as arguments to an executor

#### Usage

    executeInputSupport [ --help ] [ executor ... -- Required. The command to run on each line of input or on each additional argument. Arguments to prefix the final variable argument can be supplied prior to an initial `--`. ] [ -- ] [ ... ]

Support arguments and stdin as arguments to an executor



> Location: `bin/build/tools/sugar.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.
- executor ... -- Required. The command to run on each line of input or on each additional argument. Arguments to prefix the final variable argument can be supplied prior to an initial `--`.
- `--` - Alone after the executor forces `stdin` to be ignored. The `--` flag is also removed from the arguments passed to the executor.
- `...` - Any additional arguments are passed directly to the executor

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

File `bin/build/tools/sugar.sh`, function `executeInputSupport` was reviewed {reviewed}.

#### Errors

{error}

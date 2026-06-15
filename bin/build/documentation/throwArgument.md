### `throwArgument`

> Run `handler` with an argument error

#### Usage

    throwArgument handler [ message ... ]

Run `handler` with an argument error



> Location: `bin/build/tools/_sugar.sh`

#### Arguments

- `handler` - Function. Required. Failure command
- `message ...` - String. Optional. Error message to display.

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

File `bin/build/tools/_sugar.sh`, function `throwArgument` was reviewed {reviewed}.

#### Errors

{error}

### `returnMessage`

> Return passed in integer return code and output message to

#### Usage

    returnMessage exitCode [ message ... ]

Return passed in integer return code and output message to `stderr` (non-zero) or `stdout` (zero)



> Location: `bin/build/tools/example.sh`

#### Arguments

- `exitCode` - UnsignedInteger. Required. Exit code to return. Default is 1.
- `message ...` - String. Optional. Message to output

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

- exitCode

#### Local cache

{local_cache}

#### Environment

{environment}

#### Requires

- - [isUnsignedInteger]({rel}tools/type.md#isunsignedinteger) - Is value an unsigned integer? ([source](https://github.com/zesk/build/blob/main/bin/build/tools/example.sh#L162))[`printf`]({rel}/guide/builtin.md#printf)

#### See Also

{see}

#### Credits

Thanks to [{credits}]({source}).

#### Review Status

File `bin/build/tools/example.sh`, function `returnMessage` was reviewed {reviewed}.

#### Errors

{error}

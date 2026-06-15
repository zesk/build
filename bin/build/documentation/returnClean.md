### `returnClean`

> Delete files or directories and return the same exit code

#### Usage

    returnClean exitCode [ item ]

Delete files or directories and return the same exit code passed in.



> Location: `bin/build/tools/_sugar.sh`

#### Arguments

- `exitCode` - Integer. Required. Exit code to return.
- `item` - Exists. Optional. One or more files or folders to delete, failures are logged to stderr.

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

File `bin/build/tools/_sugar.sh`, function `returnClean` was reviewed {reviewed}.

#### Errors

{error}

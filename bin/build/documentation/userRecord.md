### `userRecord`

> Quick user database look up

#### Usage

    userRecord index [ user ] [ database ]

Look user up, output a single user database record.



> Location: `bin/build/tools/user.sh`

#### Arguments

- `index` - PositiveInteger. Required. Index (1-based) of field to select.
- `user` - String. Optional. User name to look up. Uses `whoami` if not supplied.
- `database` - File. Optional. User name database file to examine. Uses `/etc/passwd` if not supplied.

#### Reads standard input

{stdin}

#### Writes to standard output

String. Associated record with `index` and `user`.


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

- grep
- cut
- - [returnMessage]({rel}tools/sugar-core.md#returnmessage) - Return passed in integer return code and output message to ([source](https://github.com/zesk/build/blob/main/bin/build/tools/example.sh#L143))[`printf`]({rel}/guide/builtin.md#printf)
- /etc/passwd
- whoami

#### See Also

{see}

#### Credits

Thanks to [{credits}]({source}).

#### Review Status

File `bin/build/tools/user.sh`, function `userRecord` was reviewed {reviewed}.

#### Errors

{error}

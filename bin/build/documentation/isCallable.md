### `isCallable`

> Test if all arguments are callable as a command

#### Usage

    isCallable string

Test if all arguments are callable as a command
If no arguments are passed, returns exit code 1.



> Location: `bin/build/tools/type.sh`

#### Arguments

- `string` - EmptyString. Required. Path to binary to test if it is executable.

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

- `0` - All arguments are callable as a command
- `1` - One or or more arguments are callable as a command

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

File `bin/build/tools/type.sh`, function `isCallable` was reviewed {reviewed}.

#### Errors

{error}

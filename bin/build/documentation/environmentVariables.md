### `environmentVariables`

> Output a list of environment variables and ignore function definitions

#### Usage

    environmentVariables

Output a list of environment variables and ignore function definitions

both `set` and `env` output functions and this is an easy way to just output
exported variables



> Location: `bin/build/tools/environment.sh`

#### Arguments

- none

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

- [`declare`]({rel}/guide/builtin.md#declare)
- grep
- cut

#### See Also

{see}

#### Credits

Thanks to [{credits}]({source}).

#### Review Status

File `bin/build/tools/environment.sh`, function `environmentVariables` was reviewed {reviewed}.

#### Errors

{error}

### `quoteSedPattern`

> Quote sed search strings for shell use

#### Usage

    quoteSedPattern text

Quote a string to be used in a sed pattern on the command line.



> Location: `bin/build/tools/sed.sh`

#### Arguments

- `text` - EmptyString. Required. Text to quote

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

    sed "s/$(quoteSedPattern "$1")/$(quoteSedPattern "$2")/g"
    needSlash=$(quoteSedPattern '$.*/[\]^')


#### Sample Output

string quoted and appropriate to insert in a sed search or replacement phrase


#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Local cache

{local_cache}

#### Environment

{environment}

#### Requires

- [`printf`]({rel}/guide/builtin.md#printf)
- sed

#### See Also

{see}

#### Credits

Thanks to [{credits}]({source}).

#### Review Status

File `bin/build/tools/sed.sh`, function `quoteSedPattern` was reviewed {reviewed}.

#### Errors

{error}
